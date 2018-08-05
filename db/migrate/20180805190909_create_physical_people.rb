class CreatePhysicalPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :physical_people do |t|
      t.string :cpf
      t.string :name
      t.date :birthdate

      t.timestamps
    end
  end
end
