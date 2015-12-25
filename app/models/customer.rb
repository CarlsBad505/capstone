class Customer < ActiveRecord::Base
  belongs_to :user
  ZIPCODE_REGEX = /\A\d{5}(-\d{4})?\z/
  
  validates :name,
    presence: true,
    length: { minimum: 1 }
  
  validate :is_twenty_one?
  
    
  validates :zipcode,
    presence: true,
    length: { minimum: 5 },
    format: { with: ZIPCODE_REGEX }
    
  def is_twenty_one?
    if !((self.birthday + 21.years) <= Date.today)
      errors.add(:birthday, "You must be 21 years old to sign up!")
    end
  end
end
