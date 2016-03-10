class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :document_id
      t.string :last_name
      t.string :name
      t.string :email
      t.string :password

      t.timestamps null: false
    end
  end
end
