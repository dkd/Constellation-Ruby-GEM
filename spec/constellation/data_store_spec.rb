require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::DataStore do

  before(:each) do
    Constellation::DataStore.reset_instance
    @data_store = Constellation::DataStore.instance
  end

  describe "#establish_connection" do

    it "should create a new Cassandra instance" do
      @data_store.host    = "127.0.0.1"
      @data_store.port    = 9160
      @data_store.establish_connection
    end

    context "given keyspace does not exist" do
      before(:each) do
        @keyspace_name        = "TemporaryKeyspace"
        @data_store.host      = "127.0.0.1"
        @data_store.port      = 9160
        @data_store.keyspace  = @keyspace_name
        CassandraHelpers::drop_keyspace(@keyspace_name)
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
        column_family           = Cassandra::ColumnFamily.new
        column_family.keyspace  = @data_store.keyspace
        column_family.name      = "logs"
        @data_store.should_receive(:create_column_families).and_return([column_family])
        @data_store.establish_connection
      end
    end
  end

  describe "#insert" do

    before(:each) do
      @data_store.establish_connection
    end

    context "given log entry is valid" do
      before(:each) do
        @log_entry = Constellation::LogEntry.new("Sep 17 17:02:02 www1 php5: I failed.")
      end

      it "should insert the log entry into the database" do
        @data_store.insert(@log_entry)
        @data_store.instance_variable_get("@server").get(:logs, @log_entry.to_h['uuid']).should_not be_nil
      end
    end

    context "given log entry is not valid" do
      before(:each) do
        @log_entry = Constellation::LogEntry.new("Sep 17 17:02:02 php5: Fail.")
      end

      it "should raise an InvalidLogFormatError" do
        lambda {
          @data_store.establish_connection
          @data_store.insert(@log_entry)
        }.should raise_error(Constellation::InvalidLogFormatError)
      end
    end
  end

end