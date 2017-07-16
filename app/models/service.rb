class Service < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  has_attached_file :image, styles: {medium: "300x300>", small: "230x140", thumb:"100x100>"}

  validates :title, presence: true, length: {maximum:80}
  validates :description, presence: true, length: {maximum:1200}
  validates :price, presence: true
  validates :delivery_time, presence: false
  validates :revisions, presence: false
  validates :requirements, presence: true, length: {maximum:450}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
