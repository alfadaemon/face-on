class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.references :criminal
      t.integer :comparado_con
      t.timestamps
    end
  end
end
