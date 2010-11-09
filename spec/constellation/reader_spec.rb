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
      Constellation::UserInterface.should_receive(:inform).twice
      @reader.stub!(:wait_for_interrupt)
      @reader.stub!(:read_log_entries)
      @reader.start
    end

    it "should run file observation" do
      @reader.instance_variable_get("@config").instance_variable_set("@watched_files", ["logs"])
      @reader.stub!(:wait_for_interrupt)
      @reader.should_receive(:read_log_entries)
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
      @file_name = "logs"
      FileHelpers::create_file(@file_name,"Sep 17 17:02:02 www1 php5: I failed.")
      @reader.stub!(:new_system_error)
    end

    after(:each) do
      @reader.instance_variable_set("@running", true)
      thread = Thread.new {
        @reader.read_log_entries(@file_name)
      }
      # write a new log entry
      File.open(@file_name, "a+") { |f| f.write(@log_message) }
      # sleep until the reading buffer is over
      sleep(@reader.instance_variable_get("@config").reading_buffer+0.1)
      thread.kill
      FileHelpers::destroy_file(@file_name)
    end

    context "given a valid log entry" do
      before(:each) do
        stub_data_store
      end

      it "should create a new log entry" do
        Constellation::LogEntry.should_receive(:new)
        @log_message = "Sep 17 17:02:02 www1 php5: I failed."
      end

      it "should insert the log entry into the data store" do
        @config = Constellation::Config.instance
        @config.data_store.should_receive(:insert)
        @log_message = "Sep 17 17:02:02 www1 php5: I failed."
      end

      context "given @debug_mode is true" do
        before(:each) do
          @reader.instance_variable_set("@debug_mode", true)
        end

        it "should inform the user about new log entries" do
          @log_message = "Sep 17 17:02:02 www1 php5: I failed."
          Constellation::UserInterface.should_receive(:inform)
        end
      end
    end

    context "given an invalid log entry" do
      it "should insert a new system error" do
        @reader.should_receive(:new_system_error)
        @log_message = "Sep 17 17:02:02"
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

  describe "#wait_for_interrupt" do
    context "receiving a Interrupt" do
      it "should exit" do
        thread = Thread.new {
          @reader.wait_for_interrupt
        }
        thread.raise("Interrupt")
        thread.should_not be_alive
      end
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