class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.float :t_zero
      t.float :t_one
      t.float :t_two
      t.float :t_total
      t.timestamps null: false
    end
  end
end
