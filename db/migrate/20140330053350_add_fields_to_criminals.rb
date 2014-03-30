class AddFieldsToCriminals < ActiveRecord::Migration
  def change
    add_column :criminals, :nombre, :string
    add_column :criminals, :apellido, :string
    add_column :criminals, :genero, :integer
    add_column :criminals, :ficha, :string
  end
end
