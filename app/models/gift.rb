class Gift < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  before_validation :generate_unique_id, on: :create

  validates :recipient_first_name, presence: true
  validates :recipient_last_name, presence: true
  validates :recipient_email, presence: true
  validates :redeemed, presence: true, on: :update
  validates :unique_id, presence: true
  validates :gift_amount, presence: true
  validate :amount_range?, on: :create
  
  def amount_range? # Could've used :numericality as well...
    if self.gift_amount && !(self.gift_amount >= 5 && self.gift_amount <= 500)
      errors.add(:gift_amount, "Make sure your gift amount is between $5 to $500")
    end
  end
  
  def generate_unique_id
    loop do
      self.unique_id = SecureRandom.base64(64)
      break unless Gift.find_by(unique_id: unique_id)
    end
  end
  
end
