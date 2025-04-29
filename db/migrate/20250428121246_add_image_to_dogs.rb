class AddImageToDogs < ActiveRecord::Migration[8.0]
  def change
    add_column :dogs, :image, :string
  end
end
