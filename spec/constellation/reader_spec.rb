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

  describe ".read_log_entries" do
    before(:each) do
      file_name = "logs"
      FileHelpers::create_file("logs","Sep 17 17:02:02 www1 php5: I failed.")
      @file = File.open(file_name, (::File::RDONLY))
      @config = ::Constellation::Config.instance
      @config.data_store.stub!(:insert)
      Constellation::LogEntry.stub!(:new)
    end

    after(:each) do
      FileHelpers::destroy_file("logs")
    end

    it "should create a new log entry" do
      Constellation::LogEntry.should_receive(:new)
      Constellation::Reader::read_log_entries(@config, @file)
    end

    it "should insert the log entry into the data store" do
      @config.data_store.should_receive(:insert)
      Constellation::Reader::read_log_entries(@config, @file)
    end
  end

end