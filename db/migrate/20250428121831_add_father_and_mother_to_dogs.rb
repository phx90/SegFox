class AddFatherAndMotherToDogs < ActiveRecord::Migration[8.0]
  def change
    add_column :dogs, :father_id, :integer
    add_column :dogs, :mother_id, :integer
  end
end
