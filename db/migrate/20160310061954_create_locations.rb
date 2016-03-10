class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.datetime :date
      t.float :longitude
      t.float :latitude
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
