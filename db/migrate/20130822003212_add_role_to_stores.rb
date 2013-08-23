class AddRoleToStores < ActiveRecord::Migration
  def change
    add_column :stores, :role, :integer
  end
end
