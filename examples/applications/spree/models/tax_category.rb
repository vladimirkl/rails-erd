class TaxCategory < ActiveRecord::Base
  has_many :tax_rates

  validates_presence_of :name
  validates_uniqueness_of :name
end
