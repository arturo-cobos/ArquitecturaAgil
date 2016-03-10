class CreateSafeZones < ActiveRecord::Migration
  def change
    create_table :safe_zones do |t|
      t.float :coorX1
      t.float :coorX2
      t.float :coorY1
      t.float :coorY2
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
