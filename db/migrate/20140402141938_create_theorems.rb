class CreateTheorems < ActiveRecord::Migration
  def change
    create_table :theorems do |t|
      t.string :name
      t.integer :place
      t.boolean :is_item
      # t.timestamps
    end
  end
end
