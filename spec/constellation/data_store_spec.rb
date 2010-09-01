require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::DataStore do

  describe "#establish_connection" do
    before(:each) do
      @data_store = Constellation::DataStore.new
    end

    it "should create a new Cassandra instance" do
      @data_store.keyspace  = "constellation"
      @data_store.host      = "127.0.0.1:9160"
      @data_store.establish_connection
    end

    it "should check if the given keyspace exists"

    context "given keyspace exists" do
    end

    context "given keyspace does not exist" do
      it "should create the keyspace"
    end
  end

end