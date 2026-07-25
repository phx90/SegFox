class HardenDogDataIntegrity < ActiveRecord::Migration[8.0]
  def change
    change_column_default :dogs, :available, from: nil, to: false

    add_index :dogs, :breed
    add_index :dogs, :available
    add_index :dogs, :father_id
    add_index :dogs, :mother_id
    add_foreign_key :dogs, :dogs, column: :father_id, on_delete: :restrict
    add_foreign_key :dogs, :dogs, column: :mother_id, on_delete: :restrict

    add_index :dog_parents, [ :parent_id, :child_id ], unique: true
    add_foreign_key :dog_parents, :dogs, column: :parent_id, on_delete: :cascade
    add_foreign_key :dog_parents, :dogs, column: :child_id, on_delete: :cascade
  end
end
