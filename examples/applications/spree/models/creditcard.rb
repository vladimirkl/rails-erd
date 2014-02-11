class Creditcard < ActiveRecord::Base
  has_many :payments, :as => :source

  validates_numericality_of :month, :year
  validates_presence_of :number, :unless => :has_payment_profile?, :on => :create
  validates_presence_of :verification_value, :unless => :has_payment_profile?, :on => :create
end
