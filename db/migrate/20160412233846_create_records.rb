class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :collar, index: true, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.integer :breathing_freq
      t.integer :heart_freq
      t.integer :systolic
      t.integer :diastolic

      t.timestamps null: false
    end
  end
end
