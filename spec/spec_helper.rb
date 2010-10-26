$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'constellation'
require 'rspec'
require 'rspec/autorun'
Dir[File.join(File.dirname(__FILE__), "helpers", "*.rb")].each do |file|
  require file
end

RSpec.configure do |config|

end
