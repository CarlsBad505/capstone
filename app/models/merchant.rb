class Merchant < ActiveRecord::Base
  require "stripe"
  belongs_to :user
  has_many :gifts, dependent: :destroy
  before_validation :stripe_create, on: :create
  
  ZIPCODE_REGEX = /\A\d{5}(-\d{4})?\z/
  
  validates :store_name,
    presence: true,
    length: { minimum: 1 }
  
  validates :address,
    presence: true
    
  validates :city,
    presence: true
    
  validates :state,
    presence: true
    
  validates :stripe_id,
    presence: true
    
  validates :zipcode,
    presence: true,
    length: { minimum: 5 },
    format: { with: ZIPCODE_REGEX }
  
  def stripe_create
    Stripe.api_key = ENV['STRIPE_API_KEY']
    
    account = Stripe::Account.create(
      {
        country: "US",
        managed: true
      }
      )
    self.stripe_id = account.id
  end
end
