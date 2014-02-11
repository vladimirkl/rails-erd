class Resource < ActiveRecord::Base
  validates_presence_of :file
  validates_length_of :length, :maximum => 50000000
end
