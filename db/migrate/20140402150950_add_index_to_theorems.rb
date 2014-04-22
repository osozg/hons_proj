class AddIndexToTheorems < ActiveRecord::Migration
  def change
    add_index :theorems, :name
  end
end
