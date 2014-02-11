class ReturnAuthorization < ActiveRecord::Base
  belongs_to :order
  has_many :inventory_units

  validates_presence_of :order
  validates_numericality_of :amount
  validate :must_have_shipped_units
end
