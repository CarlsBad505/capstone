class AddStripeIdToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :stripe_id, :string
  end
end
