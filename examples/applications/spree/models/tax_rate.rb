class TaxRate < ActiveRecord::Base
  belongs_to :zone
  belongs_to :tax_category

  validates_presence_of :amount
  validates_numericality_of :amount
end
