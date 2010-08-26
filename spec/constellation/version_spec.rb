require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::VERSION do

  before(:all) do
    VERSION_FILE_NAME = "VERSION"
  end

  it "should equal the version given in VERSION file" do
    file = File.new(VERSION_FILE_NAME, "r")
    version = file.gets
    version.should eql(Constellation::VERSION)
  end

end