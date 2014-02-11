class Gateway < PaymentMethod
  delegate_belongs_to :provider, :authorize, :purchase, :capture, :void, :credit
  validates_presence_of :name, :type
end
