class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :store_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
