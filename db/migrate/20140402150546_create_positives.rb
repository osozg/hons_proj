class CreatePositives < ActiveRecord::Migration
  def change
    create_table :positives do |t|
      t.integer :item_id
      t.integer :theorem_id
      # t.timestamps
    end
  end
end
