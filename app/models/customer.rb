class Customer < ActiveRecord::Base
  belongs_to :user
  
  ZIPCODE_REGEX = /\A\d{5}(-\d{4})?\z/
  
  validates :name,
    presence: true,
    length: { minimum: 1 }
    
  validates :birthday,
    presence: true
  
  # validates :is_twenty_one?
    
  validates :zipcode,
    presence: true,
    length: { minimum: 5 },
    format: { with: ZIPCODE_REGEX }
    
  def is_twenty_one?
    (self.birthday + 21.years) >= Date.today ? true : false
  end
end
