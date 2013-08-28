class AddSellerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :seller, :boolean, default: false
  end
end
