class AddChargeToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :charge, :string
  end
end
