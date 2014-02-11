class Preference < ActiveRecord::Base
  belongs_to  :owner, :polymorphic => true
  belongs_to  :group, :polymorphic => true

  validates_presence_of :name, :owner_id, :owner_type
  validates_presence_of :group_type, :if => :group_id?
end
