class CriminalsController < ApplicationController
  before_action :set_criminal, only: [:show, :edit, :update, :destroy]

  # GET /criminals
  # GET /criminals.json
  def index
    @criminals = Criminal.all
  end

  # GET /criminals/1
  # GET /criminals/1.json
  def show
  end

  # GET /criminals/new
  def new
    @criminal = Criminal.new
  end

  # GET /criminals/1/edit
  def edit
  end

  # POST /criminals
  # POST /criminals.json
  def create
    @criminal = Criminal.new(criminal_params)

    respond_to do |format|
      if @criminal.save
        compare_locally @criminal.id
        #ComparisonWorker.perform_async @criminal.id
        format.html { redirect_to @criminal, notice: 'Criminal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @criminal }
      else
        format.html { render action: 'new' }
        format.json { render json: @criminal.errors, status: :unprocessable_entity }
      end
    end
  end

  def compare_locally criminal_id
    require 'pty'

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
                value=line.to_f.to_s
              end
            end
          rescue Errno::EIO#end of line
            comp.weigth = value
            Rails.logger.info("comparando #{new_criminal} con #{c.id}, resultado #{value}")
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
      end#end of bada begin
    end
  end

  # PATCH/PUT /criminals/1
  # PATCH/PUT /criminals/1.json
  def update
    respond_to do |format|
      if @criminal.update(criminal_params)
        format.html { redirect_to @criminal, notice: 'Criminal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @criminal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criminals/1
  # DELETE /criminals/1.json
  def destroy
    @criminal.destroy
    respond_to do |format|
      format.html { redirect_to criminals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criminal
      @criminal = Criminal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criminal_params
      params.require(:criminal).permit(:nombre, :apellido, :genero, :ficha, :foto)
    end
end
