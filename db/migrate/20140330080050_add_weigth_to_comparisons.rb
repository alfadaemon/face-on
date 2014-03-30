class AddWeigthToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :weigth, :real
  end
end
