class CreateVitalSigns < ActiveRecord::Migration
  def change
    create_table :vital_signs do |t|
      t.integer :systolic_p
      t.integer :diastolic_p
      t.integer :heart_rate
      t.integer :breathing_rate
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
