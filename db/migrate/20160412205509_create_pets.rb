class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.references :pet_type, index: true, foreign_key: true
      t.references :pet_status, index: true, foreign_key: true
      t.references :owner, index: true, foreign_key: true
      t.string :name
      t.string :gender
      t.string :description

      t.timestamps null: false
    end
  end
end
