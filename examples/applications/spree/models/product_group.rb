class ProductGroup < ActiveRecord::Base
  validates_presence_of :name
  validates_associated :product_scopes

  has_and_belongs_to_many :cached_products, :class_name => "Product"
  has_many :product_scopes
end
