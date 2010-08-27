require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Constellation::DataStores::Cassandra do

  before(:each) do
    @data_store = Constellation::DataStores::Cassandra.new
  end

  describe "#initialize" do
  end

  describe "#insert" do
    it "should insert the given data into Cassandra"
  end

  describe "#get" do
    it "should return the requested data"
  end

  describe "#establish_connection" do
    it "should establish the connection" do
      ::Cassandra.should_receive(:new)
      @data_store.establish_connection
    end
  end

  describe "#disconnect" do
    it "should close the connection"
  end

end