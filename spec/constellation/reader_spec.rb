require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Reader do

  before(:each) do
    Constellation::Config.reset_instance
    @reader = Constellation::Reader.new(Constellation::Config.instance)
    @reader.instance_variable_get("@monitor").stub!(:run)
  end

  describe "#start" do
    it "should run file observation" do
      @reader.instance_variable_get("@monitor").should_receive(:run)
      @reader.start
    end
  end

end