class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :tales, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  before_save { self.role ||= :standard }
  
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  
  enum role: [:standard, :author, :admin]
  
   def avatar_url(user)
     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
   end
end
