require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:user) { User.create!(email: 'john.snow@gmail.com', password: 'winteriscoming') }
  let(:customer) { Customer.create!(name: 'john snow', birthday: '02/06/1415', zipcode: '00104', user: user ) }
  
  # Association Specs
  it { should belong_to(:user) } 
  it { should have_many(:gifts) }
  
  # Validates Name
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }
  
  # Validates Birthday
  it { should validate_presence_of(:birthday) }

  # Validates Zipcode
  it { should validate_presence_of(:zipcode) }
  it { should validate_length_of(:zipcode).is_at_least(5) }
  it { should allow_value('00000').for(:zipcode) }
  it { should_not allow_value('9056').for(:zipcode) }
  
  describe 'attributes' do
    it "should respond to name" do
      expect(customer).to respond_to(:name)
    end
    
    it "should respond to birthday" do
      expect(customer).to respond_to(:birthday)
    end
    
    it "should respond to zipcode" do
      expect(customer).to respond_to(:zipcode) 
    end
    
    # Validates user is of age
    it "should verify user is 21 years old" do
      expect(customer.is_twenty_one?).to eq(true)
    end
  end
end
