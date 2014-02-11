require "rubygems"
require "bundler/setup"

require "active_record"
require "test/unit"
require "active_support/test_case"
require File.dirname(__FILE__) + '/isolation'
require "rails_erd/domain"

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

class ActiveRecord::Base
  def self.clear_cache! # :nodoc:
    #connection_pool.clear_reloadable_connections!
  end
end

class ActiveSupport::TestCase
  include RailsERD

  teardown :reset_domain

  def create_table(table, columns = {}, pk = nil)
    opts = if pk then { :primary_key => pk } else { :id => false } end
    ActiveRecord::Schema.instance_eval do
      suppress_messages do
        create_table table, opts do |t|
          columns.each do |column, type|
            t.send type, column
          end
        end
      end
    end
    ActiveRecord::Base.clear_cache!
  end

  def add_column(*args)
    ActiveRecord::Schema.instance_eval do
      suppress_messages do
        add_column *args
      end
    end
    ActiveRecord::Base.clear_cache!
  end

  def create_model(name, *args, &block)
    superklass = args.first.kind_of?(Class) ? args.shift : ActiveRecord::Base
    columns = args.first || {}
    klass = Object.const_set name.to_sym, Class.new(superklass)
    if superklass == ActiveRecord::Base || superklass.abstract_class?
      create_table Object.const_get(name.to_sym).table_name, columns, Object.const_get(name.to_sym).primary_key rescue nil
    end
    klass.class_eval(&block) if block_given?
    Object.const_get(name.to_sym)
  end

  def create_models(*names)
    names.each do |name|
      create_model name
    end
  end

  def collect_stdout
    stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.rewind
    $stdout.read
  ensure
    $stdout = stdout
  end

  def create_simple_domain
    create_model "Beer", :bar => :references do
      belongs_to :bar
    end
    create_model "Bar"
  end

  def create_one_to_one_assoc_domain
    create_model "One" do
      has_one :other
    end
    create_model "Other", :one => :references do
      belongs_to :one
    end
  end

  def create_one_to_many_assoc_domain
    create_model "One" do
      has_many :many
    end
    create_model "Many", :one => :references do
      belongs_to :one
    end
  end

  def create_many_to_many_assoc_domain
    create_model "Many" do
      has_and_belongs_to_many :more
    end
    create_model "More" do
      has_and_belongs_to_many :many
    end
    create_table "manies_mores", :many_id => :integer, :more_id => :integer
  end

  def create_specialization
    create_model "Beverage", :type => :string
    create_model "Beer", Beverage
  end

  def create_polymorphic_generalization
    create_model "Cannon"
    create_model "Galleon" do
      has_many :cannons, :as => :defensible
    end
  end

  def create_abstract_generalization
    create_model "Structure" do
      self.abstract_class = true
    end
    create_model "Palace", Structure
  end

  private

  def reset_domain
    if defined? ActiveRecord
      Class.subclasses_of(ActiveRecord::Base).each do |model|
        model.reset_column_information
        Object.send :remove_const, model.name.to_sym
      end
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.drop_table table
      end
      ActiveSupport::Dependencies::clear
      ActiveRecord::Base.clear_cache!
    end
  end
end
