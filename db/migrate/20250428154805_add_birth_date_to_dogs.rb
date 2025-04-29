class AddBirthDateToDogs < ActiveRecord::Migration[8.0]
  def change
    add_column :dogs, :birth_date, :date
  end
end
