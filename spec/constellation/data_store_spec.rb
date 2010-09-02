require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::DataStore do

  describe "#establish_connection" do
    before(:each) do
      @data_store = Constellation::DataStore.new
    end

    it "should create a new Cassandra instance" do
      @data_store.host    = "127.0.0.1"
      @data_store.port    = 9160
      @data_store.establish_connection
    end

    context "given keyspace exists" do
    end

    context "given keyspace does not exist" do
      before(:each) do
        @keyspace_name        = "TemporaryKeyspace"
        @data_store.host      = "127.0.0.1"
        @data_store.port      = 9160
        @data_store.keyspace  = @keyspace_name
      end
      after(:each) do
        CassandraHelpers::drop_keyspace(@keyspace_name)
      end

      it "should create a new keyspace" do
        server = Cassandra.new("system", "#{@data_store.host}:#{@data_store.port}")
        Cassandra.stub!(:new).and_return(server)
        server.should_receive(:add_keyspace)
        @data_store.establish_connection
      end

      it "should create a new column family" do
        column_family       = Cassandra::ColumnFamily.new
        column_family.table = @data_store.keyspace
        column_family.name  = "logs"
        @data_store.should_receive(:create_column_families).and_return([column_family])
        @data_store.establish_connection
      end
    end
  end

end