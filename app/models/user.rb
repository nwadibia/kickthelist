class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins 
  has_attached_file :image, :styles => { :medium => "100x100>", :thumb => "10x10#" }, :default_url => "/images/:style/missing.png"

  validates :name, presence: true
  validates :name, length: {maximum: 15 }
  validates :name, length: {minimum: 2 }
  validates :name, uniqueness: true 
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
