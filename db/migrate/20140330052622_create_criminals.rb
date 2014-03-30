class CreateCriminals < ActiveRecord::Migration
  def change
    create_table :criminals do |t|

      t.timestamps
    end
  end
end
