class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins 

  validates :name, presence: true
  validates :name, length: {maximum: 15 }
  validates :name, length: {minimum: 2 }
  validates :name, uniqueness: true 
end
