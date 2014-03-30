class AddWeigthToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :weigth, :float
  end
end
