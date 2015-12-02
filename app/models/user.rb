class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 6 }
  
end
