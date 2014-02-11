require 'rails_erd'

Dir[File.join(File.dirname(__FILE__), '..', 'tasks', '*.rake')].each do |f|
  puts f
  load f
end

