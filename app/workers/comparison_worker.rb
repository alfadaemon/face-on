# DO face comprisons task
require 'pty'

class ComparisonWorker
  include Sidekiq::Worker

  def perform(criminal_id)
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
      comp.weight = 1
      comp.save
      Rails.logger.info("comparando #{new_criminal} con #{c.id}")
    end
    puts 'Doing hard work'
  end
end