# DO face comprisons task
require 'pty'

class ComparisonWorker
  include Sidekiq::Worker

  def perform(criminal_id)

    puts 'Doing hard work'

    value = 0.0

    new_criminal = Criminal.find(criminal_id)

    if new_criminal.nil?
      Rails.logger.info("Criminal con id #{criminal_id} no existe")
      return
    else
      Rails.logger.info("Criminal con id #{criminal_id} econtrado!")
    end

    Rails.logger.info("Obteniendo todos los criminales")
    criminals = Criminal.where.not id: criminal_id

    criminals.each do |c|
      comp = Comparison.new
      comp.criminal = new_criminal
      comp.comparado_con = c.id

      #Calcular el weigth de la comparacion de las fotos
      command_to_exec = "br -algorithm FaceRecognition -compare #{new_criminal.foto.path} #{c.foto.path}"
      @curr_pid = 0
      begin
        PTY.spawn( command_to_exec ) do |stdin, stdout, pid|
          @curr_pid = pid
          puts "SPAWN PID #{pid} filenames: '#{new_criminal.foto.url(:thumb)}', '#{c.foto.url(:thumb)}'"

          begin
            stdin.each do |line|
              if (line.to_f > 0.0 ) #dirty hack please fix, we shouldnt be doing this ./br should only ouput float
                value=line.to_f
              end
            end
          rescue Errno::EIO#end of line
            comp.weigth = value
            Rails.logger.info("comparando #{new_criminal.id} con #{c.id}, resultado #{value}")
          end#end of begin for iterating over stdin
          Process.wait(pid)#make sure objects ends
        end#end of PTY spawn
        Rails.logger.info("[waiting / killing]")
        Rails.logger.info(@curr_pid)
          # Process.wait(@curr_pid)#make sure objects ends
          # Process.kill('INT', @curr_pid)#doubly make sure process ends :)

          # rescue PTY::ECHILD
          # puts "The child process died!PID #{pid} filenames #{filename_one} , #{filename_two}"
      rescue PTY::ChildExited
        # binding.pry
        puts "The child process exited!PID #{pid} filenames #{filename_one} , #{filename_two}"
      end#end of bada bin
      comp.save
    end
  end
end