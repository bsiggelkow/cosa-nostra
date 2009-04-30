ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'
require 'factory_girl'

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.include AuthenticatedTestHelper

  config.global_fixtures = :all

  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr 
end

# YOU CAN DO COOL STUFF LIKE DEFINE MACROS AND SUCH LIKE THIS
def table_has_columns(clazz, type, *column_names)
  column_names.each do |column_name|
    column = clazz.columns.select {|c| c.name == column_name.to_s}.first
    it "has a #{type} named #{column_name}" do
      column.should_not be_nil
      column.type.should == type.to_sym
    end
  end
end

def route_matches(path, method, params)
  it "maps #{params.inspect} to #{path.inspect}" do
    route_for(params).should == path
  end

  it "generates params #{params.inspect} from #{method.to_s.upcase} to #{path.inspect}" do
    params_from(method.to_sym, path).should == params
  end
end

def requires_presence_of(clazz, field)
  it "requires #{field}" do
    record = Factory.build(clazz.to_s.underscore.to_sym, field.to_sym => nil)
    record.should_not be_valid
    record.errors.on(field.to_sym).should_not be_nil
  end
end
