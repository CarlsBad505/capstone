class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.text :message
      t.integer :gift_amount
      t.string :recipient_first_name
      t.string :recipient_last_name
      t.string :recipient_email
      t.boolean :redeemed, default: false
      t.string :unique_id
      t.references :customer, index: true, foreign_key: true
      t.references :merchant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
