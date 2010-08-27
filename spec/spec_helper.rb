$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'constellation'
require 'spec'
require 'spec/autorun'
Dir[File.join(File.dirname(__FILE__), "helpers", "*.rb")].each do |file|
  require file
end

Spec::Runner.configure do |config|

end
