class SourceImage < ActiveRecord::Base
  attr_accessible :category, :url

  belongs_to :animal
  has_many :captioned_images
  
  def adoption_info_url
    animal.url
  end
end
