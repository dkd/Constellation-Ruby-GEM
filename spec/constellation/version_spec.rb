require "spec_helper"

describe Constellation::VERSION do
  
  before(:all) do
    VERSION_FILE = "VERSION"
  end
  
  it "should equal the version given in VERSION file" do
    file = File.new(VERSION_FILE, "r")
    version = file.gets
    version.should eql(Constellation::VERSION)
  end
  
end