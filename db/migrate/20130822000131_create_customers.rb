class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :store_id
      t.integer :user_id

      t.timestamps
    end
  end
end
