class Country < ActiveRecord::Base
  has_many :states
  has_one :zone_member, :as => :zoneable
  has_one :zone, :through => :zone_member

  validates_presence_of :name, :iso_name
end
