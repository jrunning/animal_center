class Animal < ActiveRecord::Base
  attr_accessible :age, :center_url_xid, :center_xid, :name, :url

  has_many :source_images
  has_many :captioned_images, through: :source_images
end
