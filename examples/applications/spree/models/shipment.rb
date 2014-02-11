class Shipment < ActiveRecord::Base
  belongs_to :order
  belongs_to :shipping_method
  belongs_to :address
  has_many :state_events, :as => :stateful
  has_many :inventory_units

  validates_presence_of :inventory_units, :if => :require_inventory
  validate :shipping_method
end
