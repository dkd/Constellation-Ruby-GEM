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
      Constellation::Reader.stub!(:new_system_error)
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

  describe ".new_system_error" do
    before(:each) do
      @config = Constellation::Config.instance
      @config.data_store.stub!(:insert)
    end

    it "should log it as 'system' machine" do
      @log_entry = Constellation::LogEntry.new
      Constellation::LogEntry.stub!(:new).and_return(@log_entry)
      @log_entry.should_receive(:machine=)
      Constellation::Reader.new_system_error(@config, Constellation::ConstellationError)
    end

    it "should insert a new log entry" do
      @config.data_store.should_receive(:insert)
      Constellation::Reader.new_system_error(@config, Constellation::ConstellationError)
    end
  end

end