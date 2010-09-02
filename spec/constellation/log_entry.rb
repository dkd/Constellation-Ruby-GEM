require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::LogEntry do

  before(:each) do
    @log_entry = Constellation::LogEntry.new
    @log_entry.machine      = "www1"
    @log_entry.application  = "php5"
    @log_entry.message      = "I failed"
    @log_entry.timestamp    = Time.now.to_i
  end

  describe "#to_json" do
    it "should create valid json" do
      lambda { JSON.parse(@log_entry.to_json) }.should_not raise_error
    end
  end

end