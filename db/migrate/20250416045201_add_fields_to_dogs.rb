class AddFieldsToDogs < ActiveRecord::Migration[8.0]
  def change
    # add_column :dogs, :name, :string
    add_column :dogs, :breed, :string
    add_column :dogs, :age, :integer
  end
end
