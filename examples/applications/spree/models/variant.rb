class Variant < ActiveRecord::Base
  belongs_to :product
  delegate_belongs_to :product, :name, :description, :permalink, :available_on, :tax_category_id, :shipping_category_id, :meta_description, :meta_keywords

  has_many :inventory_units
  has_many :line_items
  has_and_belongs_to_many :option_values
  has_many :images, :as => :viewable, :order => :position, :dependent => :destroy

  validate :check_price
  validates_presence_of :price
  validates_numericality_of :cost_price, :allow_nil => true if Variant.table_exists? && Variant.column_names.include?("cost_price")
end
