class CreateSafeZones < ActiveRecord::Migration
  def change
    create_table :safe_zones do |t|
      t.references :pet, index: true, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.float :radium

      t.timestamps null: false
    end
  end
end
