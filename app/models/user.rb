class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_one :customer, dependent: :destroy
  accepts_nested_attributes_for :customer, allow_destroy: true
  
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 6 }
  
end
