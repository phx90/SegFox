class CreateDogParents < ActiveRecord::Migration[8.0]
  def change
    create_table :dog_parents do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
  end
end
