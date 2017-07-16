class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :fullname, presence: true, length: {maximum: 50}
  validates :description, presence: false, length: {maximum: 1500}

  has_many :services
  has_many :orders
end
