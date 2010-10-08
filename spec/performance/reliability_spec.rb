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
BUFFER_TIME = 5
# example log message
LOG_MESSAGE = "Sep 17 17:02:02 www1 php5: I failed.\n"

describe "Constellation reliability tests" do

  def create_log_entries(log_file_name, iterations, seconds)
    iterations.times {
      file = File.open(log_file_name, "a") { |f| f.write(LOG_MESSAGE) }
      sleep(seconds)
    }
    sleep(BUFFER_TIME)
    trigger_fssm(log_file_name)
  end

  def trigger_fssm(log_file_name)
    file = File.open(log_file_name, "a") { |f| f.write(LOG_MESSAGE) }
  end

  before(:each) do
    @server = Cassandra.new("constellation")
    @log_file_name = "logs"
  end

  after(:each) do
  end

  context "one log entry per write action" do

    context "within 5 seconds" do
      before(:each) do
        @server.clear_keyspace! if @server.count_range(:logs) > 0
      end

      it "should handle 5 actions" do
        create_log_entries(@log_file_name, 5, 1)
        @server.count_range(:logs).should >= 5
      end

      it "should handle 10 actions" do
        create_log_entries(@log_file_name, 10, 0.5)
        @server.count_range(:logs).should >= 10
      end

      it "should handle 20 actions" do
        create_log_entries(@log_file_name, 20, 0.25)
        @server.count_range(:logs).should >= 20
      end

      it "should handle 50 actions" do
        create_log_entries(@log_file_name, 50, 0.1)
        @server.count_range(:logs).should >= 50
      end

      it "should handle 100 actions" do
        create_log_entries(@log_file_name, 100, 0.05)
        @server.count_range(:logs).should >= 100
      end
    end

    context "within 10 seconds" do
    end

    context "within 30 seconds" do
    end

    context "within 1 minute" do
    end

  end

  context "multiple log entries per write action" do
  end

end