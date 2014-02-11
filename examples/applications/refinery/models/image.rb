class Image < ActiveRecord::Base
  validates_presence_of :image
  validates_length_of  :image, :maximum => 20000000
end
