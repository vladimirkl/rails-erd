class Zone < ActiveRecord::Base
  has_many :zone_members
  has_many :tax_rates
  has_many :shipping_methods

  validates_presence_of :name
  validates_numericality_of :name
end
