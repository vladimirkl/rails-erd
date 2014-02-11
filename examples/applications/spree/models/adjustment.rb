class Adjustment < ActiveRecord::Base
  belongs_to :order
  belongs_to :source, :polymorphic => true
  belongs_to :originator, :polymorphic => true

  validates_presence_of :label
  validates_numericality_of :amount
end
