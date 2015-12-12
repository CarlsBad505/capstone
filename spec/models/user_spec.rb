require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "john.snow@gmail.com", password: "winteriscoming") }
  let(:customer) { Customer.create!(name: 'john snow', birthday: '02/06/1415', zipcode: '00104', user: user) }
  let(:merchant) { Merchant.create!(store_name: "Doctors Orders", address: '1234 Welton Street', address2: nil, city: 'Denver', state: 'Colorado', zipcode: '80202', user: user) }

  # Association Specs
  it { should have_one(:customer) }
  it { should have_one(:merchant) }

  # Validates Email
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:email).is_at_least(6) }
  it { should allow_value("john.snow@gmail.com").for(:email) }
  it { should_not allow_value("john.snowgmail.com").for(:email) }
  
  # Validates Password
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(8) }
  
  describe "attributes" do
    it "should respond to email" do
      expect(user).to respond_to(:email)
    end
    
    it "should respond to password" do
      expect(user).to respond_to(:password)
    end
  end
end
