class CreateCollars < ActiveRecord::Migration
  def change
    create_table :collars do |t|
      t.references :pet, index: true, foreign_key: true
      t.string :reference
      t.string :description

      t.timestamps null: false
    end
  end
end
