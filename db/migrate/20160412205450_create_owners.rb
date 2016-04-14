class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :email
      t.string :name
      t.string :last_name
      t.string :document_id
      t.string :phone
      t.string :cellphone

      t.timestamps null: false
    end
  end
end
