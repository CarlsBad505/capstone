require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let(:user) { User.create!(email: 'john.snow@gmail.com', password: 'winteriscoming') }
  let(:merchant) { Merchant.create!(store_name: "Doctors Orders", address: '1234 Welton Street', address2: nil, city: 'Denver', state: 'Colorado', zipcode: '80202', user: user) }
  
  # Association spec
  it { should belong_to(:user) }
end

