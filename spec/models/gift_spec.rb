require 'rails_helper'

RSpec.describe Gift, type: :model do
  let(:user) { User.create!(email: 'john.snow@gmail.com', password: 'winteriscoming') }
  let(:merchant) { Merchant.create!(store_name: "Doctors Orders", address: '1234 Welton Street', address2: nil, city: 'Denver', state: 'Colorado', zipcode: '80202', user: user) }
  let(:customer) { Customer.create!(name: 'john snow', birthday: '02/06/1415', zipcode: '00104', user: user ) }
  let(:gift) { Gift.create!(recipient_first_name: "Ygritte", recipient_last_name: "Wild", recipient_email: "ygritte.wild@gmail.com", message: "Sorry you died.", gift_amount: 50, redeemed: false) }
  
  # Association Specs
  it { should belong_to(:customer) }
  it { should belong_to(:merchant) }
  
  # Validates First Name
  it { should validate_presence_of(:recipient_first_name) }
  
  # Validates Last Name
  it { should validate_presence_of(:recipient_last_name) }
  
  # Validates Email
  it { should validate_presence_of(:recipient_email) }
  
  # Validates Gift Amount
  it { should validate_presence_of(:gift_amount) }
  
  # Validates Boolean (:redeemed)
  # it { should validate_presence_of(:redeemed) }
  
  # Validates Unique ID
  it { should validate_presence_of(:unique_id) }
  
  describe 'attributes' do
    it "should respond to" do
      expect(gift).to respond_to(:recipient_first_name)
    end
    
    it "should respond to" do
      expect(gift).to respond_to(:recipient_last_name)
    end
    
    it "should respond to" do
      expect(gift).to respond_to(:recipient_email)
    end
    
    it "should respond to" do
      expect(gift).to respond_to(:message)
    end
    
    it "should respond to" do
      expect(gift).to respond_to(:gift_amount)
    end
    
    it "should respond to" do
      expect(:redeemed).to eq(false)
    end
    
    it "should respond to" do
      expect(gift).to respond_to(:unique_id)
    end
  end
  
end
