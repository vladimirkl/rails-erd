class Taxon < ActiveRecord::Base
  belongs_to :taxonomy
  has_and_belongs_to_many :products

  validates_presence_of :name
end
