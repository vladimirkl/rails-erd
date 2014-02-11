class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :variant
  has_one :product, :through => :variant

  validates_presence_of :variant
  validates_numericality_of :quantity,  :only_integer => true, :message => I18n.t("validation.must_be_int")
  validates_numericality_of :price
end
