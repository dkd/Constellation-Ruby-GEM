require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Reader do

  def stub_data_store
    @config = Constellation::Config.instance
    @config.data_store.stub!(:insert)
  end

  before(:each) do
    Constellation::Config.reset_instance
    @reader = Constellation::Reader.new(Constellation::Config.instance)
    @reader.instance_variable_set("@running", false)
  end

  describe "#start" do
    it "should inform about the starting process" do
      Constellation::UserInterface.should_receive(:inform).once
      @reader.stub!(:wait_for_interrupt)
      @reader.stub!(:read_log_entries)
      @reader.start
    end

    it "should wait for quitting" do
      @reader.stub!(:read_log_entries)
      @reader.should_receive(:wait_for_interrupt)
      @reader.start
    end
  end

  describe "#read_log_entries" do
    before(:each) do
      @reader.stub!(:new_system_error)
    end

    context "given not enough permissions for opening the log file" do
      before(:each) do
        @reader.stub!(:quit_application)
        File.stub!(:open).and_raise(Errno::EACCES)
      end

      it "should write an error to the command line" do
        Constellation::UserInterface.should_receive(:error)
        @reader.read_log_entries("logs")
      end

      it "should quit the application" do
        @reader.should_receive(:quit_application)
        @reader.read_log_entries("logs")
      end
    end
  end

  describe "#new_system_error" do
    before(:each) do
      stub_data_store
    end

    it "should log it as 'system' machine" do
      @log_entry = Constellation::LogEntry.new
      Constellation::LogEntry.stub!(:new).and_return(@log_entry)
      @log_entry.should_receive(:machine=)
      @reader.new_system_error(Constellation::ConstellationError)
    end

    it "should insert a new log entry" do
      @config.data_store.should_receive(:insert)
      @reader.new_system_error(Constellation::ConstellationError)
    end
  end

  describe "#quit_application" do
    it "should confirm about the quit" do
      Kernel.stub!(:exit)
      Constellation::UserInterface.should_receive(:confirm)
      @reader.quit_application
    end

    it "should kill the current process" do
      Kernel.should_receive(:exit)
      @reader.quit_application
    end
  end

end
