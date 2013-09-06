class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :card_last4
      t.string :card_type
      t.string :card_exp_month
      t.string :card_exp_year
      
      #t.string :stripe_card_token

      t.timestamps
    end
  end
end
