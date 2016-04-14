class CreateLocationHistories < ActiveRecord::Migration
  def change
    create_table :location_histories do |t|
      t.references :pet, index: true, foreign_key: true
      t.datetime :record_date
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
