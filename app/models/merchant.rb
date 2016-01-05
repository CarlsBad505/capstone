class Merchant < ActiveRecord::Base
  belongs_to :user
  has_many :gifts, dependent: :destroy
  
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
    
  validates :zipcode,
    presence: true,
    length: { minimum: 5 },
    format: { with: ZIPCODE_REGEX }

end
