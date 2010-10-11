require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'cassandra/0.7'

#
# == How to run these performance tests
#
# === Requirements
#
# * Running cassandra server
# * Installed constellation gem
#
# === Running tests
#
# * cd spec/performance/
# * constellation start
# * ruby reliability_spec.rb
# * Watch constellation scaling, hopefully :-)
#
#

# seconds to wait before counting the number of inserted log entries
BUFFER_TIME = 3
# example log message
LOG_MESSAGE = "Sep 17 17:02:02 www1 php5: I failed.\n"

describe "Constellation reliability tests" do

  def create_log_entries(log_file_name, iterations, seconds)
    iterations.times {
      file = File.open(log_file_name, "a") { |f| f.write(LOG_MESSAGE) }
      sleep(seconds)
    }
    sleep(BUFFER_TIME)
  end

  before(:each) do
    @server = Cassandra.new("constellation")
    @log_file_name = "logs"
  end

  after(:each) do
  end

  context "one log entry per write action" do

    before(:each) do
      begin
        @server.clear_keyspace!
      rescue
      end
    end

    context "within 1 second" do
      it "should handle 5 actions" do
        create_log_entries(@log_file_name, 5, 0.2)
        @server.count_range(:logs).should == 5
      end

      it "should handle 10 actions" do
        create_log_entries(@log_file_name, 10, 0.1)
        @server.count_range(:logs).should == 10
      end

      it "should handle 20 actions" do
        create_log_entries(@log_file_name, 20, 0.05)
        @server.count_range(:logs).should == 20
      end

      it "should handle 50 actions" do
        create_log_entries(@log_file_name, 50, 0.002)
        @server.count_range(:logs).should == 50
      end

      it "should handle 100 actions" do
        create_log_entries(@log_file_name, 100, 0.001)
        @server.count_range(:logs).should == 100
      end

      it "should handle 200 actions" do
        create_log_entries(@log_file_name, 200, 0.0005)
        @server.count_range(:logs, { :count => 200 }).should == 200
      end

      it "should handle 400 actions" do
        create_log_entries(@log_file_name, 400, 0.00025)
        @server.count_range(:logs, { :count => 400 }).should == 400
      end

      it "should handle 1000 actions" do
        create_log_entries(@log_file_name, 1000, 0.0001)
        @server.count_range(:logs, { :count => 1000 }).should == 1000
      end
    end

    context "within 5 seconds" do
      it "should handle 5 actions" do
        create_log_entries(@log_file_name, 5, 1)
        @server.count_range(:logs).should == 5
      end

      it "should handle 10 actions" do
        create_log_entries(@log_file_name, 10, 0.5)
        @server.count_range(:logs).should == 10
      end

      it "should handle 20 actions" do
        create_log_entries(@log_file_name, 20, 0.25)
        @server.count_range(:logs).should == 20
      end

      it "should handle 50 actions" do
        create_log_entries(@log_file_name, 50, 0.1)
        @server.count_range(:logs).should == 50
      end

      it "should handle 100 actions" do
        create_log_entries(@log_file_name, 100, 0.05)
        @server.count_range(:logs).should == 100
      end

      it "should handle 200 actions" do
        create_log_entries(@log_file_name, 200, 0.025)
        @server.count_range(:logs, { :count => 200 }).should == 200
      end

      it "should handle 400 actions" do
        create_log_entries(@log_file_name, 400, 0.0125)
        @server.count_range(:logs, { :count => 400 }).should == 400
      end

      it "should handle 1000 actions" do
        create_log_entries(@log_file_name, 1000, 0.005)
        @server.count_range(:logs, { :count => 1000 }).should == 1000
      end

      it "should handle 2000 actions" do
        create_log_entries(@log_file_name, 2000, 0.0025)
        @server.count_range(:logs, { :count => 2000 }).should == 2000
      end

      it "should handle 3000 actions" do
        create_log_entries(@log_file_name, 3000, 0.00167)
        @server.count_range(:logs, { :count => 3000 }).should == 3000
      end

      it "should handle 5000 actions" do
        create_log_entries(@log_file_name, 5000, 0.001)
        @server.count_range(:logs, { :count => 5000 }).should == 5000
      end
    end

    context "within 10 seconds" do
      it "should handle 10 actions" do
        create_log_entries(@log_file_name, 10, 1)
        @server.count_range(:logs).should == 10
      end

      it "should handle 20 actions" do
        create_log_entries(@log_file_name, 20, 0.5)
        @server.count_range(:logs).should == 20
      end

      it "should handle 200 actions" do
        create_log_entries(@log_file_name, 200, 0.05)
        @server.count_range(:logs, { :count => 200 }).should == 200
      end

      it "should handle 2000 actions" do
        create_log_entries(@log_file_name, 2000, 0.005)
        @server.count_range(:logs, { :count => 2000 }).should == 2000
      end

      it "should handle 10000 actions" do
        create_log_entries(@log_file_name, 10000, 0.001)
        @server.count_range(:logs, { :count => 10000 }).should == 10000
      end
    end

    context "within 30 seconds" do
      it "should handle 30 actions" do
        create_log_entries(@log_file_name, 30, 1)
        @server.count_range(:logs).should == 30
      end

      it "should handle 60 actions" do
        create_log_entries(@log_file_name, 60, 0.5)
        @server.count_range(:logs).should == 60
      end

      it "should handle 300 actions" do
        create_log_entries(@log_file_name, 300, 0.1)
        @server.count_range(:logs, { :count => 300 }).should == 300
      end

      it "should handle 3000 actions" do
        create_log_entries(@log_file_name, 3000, 0.01)
        @server.count_range(:logs, { :count => 3000 }).should == 3000
      end

      it "should handle 30000 actions" do
        create_log_entries(@log_file_name, 30000, 0.001)
        @server.count_range(:logs, { :count => 30000 }).should == 30000
      end
    end

    context "within 1 minute" do
      it "should handle 60 actions" do
        create_log_entries(@log_file_name, 60, 1)
        @server.count_range(:logs).should == 60
      end

      it "should handle 120 actions" do
        create_log_entries(@log_file_name, 120, 0.5)
        @server.count_range(:logs).should == 120
      end

      it "should handle 1200 actions" do
        create_log_entries(@log_file_name, 1200, 0.05)
        @server.count_range(:logs, { :count => 1200 }).should == 1200
      end

      it "should handle 12000 actions" do
        create_log_entries(@log_file_name, 12000, 0.005)
        @server.count_range(:logs, { :count => 12000 }).should == 12000
      end

      it "should handle 60000 actions" do
        create_log_entries(@log_file_name, 60000, 0.001)
        @server.count_range(:logs, { :count => 60000 }).should == 60000
      end
    end

  end

  context "multiple log entries per write action" do
  end

end