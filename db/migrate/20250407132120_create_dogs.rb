class CreateDogs < ActiveRecord::Migration[8.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
