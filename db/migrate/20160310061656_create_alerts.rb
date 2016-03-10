class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.datetime :alert_date
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
