class MailMethod < ActiveRecord::Base
  validates_presence_of :environment
end
