require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::LogEntry do

  describe "#initialize" do
    it "should generate a new UUID" do
      @uuid = mock(:UUID)
      UUID.stub!(:new).and_return(@uuid)
      @uuid.should_receive(:generate)
      Constellation::LogEntry.new
    end
  end

  describe "#parse" do
    context "valid line of log file" do
      before(:each) do
        @time         = "Sep 17 17:02:02"
        @machine      = "www1"
        @application  = "php5"
        @message      = "I fail!"
        @log_entry    = Constellation::LogEntry.new
        @log_entry.parse("#{@time} #{@machine} #{@application}: #{@message}")
      end

      it "should parse the machine correctly" do
        @log_entry.machine.should eql(@machine)
      end

      it "should parse the time correctly" do
        @log_entry.time.should eql(Time.parse(@time))
      end

      it "should parse the application correctly" do
        @log_entry.application.should eql(@application)
      end

      it "should parse the message correctly" do
        @log_entry.message.should eql(@message)
      end

      it "should be valid" do
        @log_entry.should be_valid
      end
    end

    context "invalid line of log file" do
      before(:each) do
        @log_entry = Constellation::LogEntry.new
        @log_entry.parse("Sep 17 17:02:02 php5: Fail.")
      end

      it "should not be valid" do
        @log_entry.should_not be_valid
      end
    end
  end

  describe "#slice_line_from" do
    it "should return the substring starting at the given position" do
      @log_entry = Constellation::LogEntry.new
      @log_entry.slice_line_from("Just a test", 5).should eql("a test")
    end
  end

  describe "#to_h" do
    before(:each) do
      @log_entry = Constellation::LogEntry.new("Sep 17 17:02:02 www1 php5: I failed.")
    end

    it "should create valid json" do
      @log_entry.to_h.should be_an(Hash)
    end

    describe ":key" do
      it "should be parsed from its time" do
        @log_entry.to_h['key'].should eql("#{Time.now.year}/9/17")
      end
    end

    describe ":uuid" do
      it "should be a String" do
        @log_entry.to_h['uuid'].should be_a(String)
      end
    end
  end

end