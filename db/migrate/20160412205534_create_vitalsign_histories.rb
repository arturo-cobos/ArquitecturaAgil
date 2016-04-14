class CreateVitalsignHistories < ActiveRecord::Migration
  def change
    create_table :vitalsign_histories do |t|
      t.references :pet, index: true, foreign_key: true
      t.datetime :record_date
      t.integer :breathing_freq
      t.integer :heart_freq
      t.integer :systolic
      t.integer :diastolic

      t.timestamps null: false
    end
  end
end
