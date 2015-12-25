require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let(:user) { User.create!(email: 'john.snow@gmail.com', password: 'winteriscoming') }
  let(:merchant) { Merchant.create!(store_name: "Doctors Orders", address: '1234 Welton Street', address2: nil, city: 'Denver', state: 'Colorado', zipcode: '80202', user: user) }
  
  # Association spec
  it { should belong_to(:user) }
  
  # Name validations
  it { should validate_presence_of(:store_name) }
  it { should validate_length_of(:store_name).is_at_least(1) }
  
  # Address validations (:address2 is optional)
  it { should validate_presence_of(:address) }
  
  # City validations
  it { should validate_presence_of(:city) }
  
  # State validations
  it { should validate_presence_of(:state) }
  
  # Zipcode validations
  it { should validate_presence_of(:zipcode) }
  it { should validate_length_of(:zipcode).is_at_least(5) }
  it { should allow_value('00000').for(:zipcode) }
  it { should_not allow_value('9056').for(:zipcode) }
  
  describe "attributes" do
    it "should respond to store_name" do
      expect(merchant).to respond_to(:store_name)
    end
    
    it "should respond to address" do
      expect(merchant).to respond_to(:address)
    end
    
    it "should respond to address2" do
      expect(merchant).to respond_to(:address2)
    end
    
    it "should respond to city" do
      expect(merchant).to respond_to(:city)
    end
    
    it "should respond to state" do
      expect(merchant).to respond_to(:state)
    end
    
    it "should respond to zipcode" do
      expect(merchant).to respond_to(:zipcode)
    end
  end
end

