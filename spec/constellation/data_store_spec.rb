require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::DataStore do

  def mock_server
    @cassandra = mock(Cassandra)
    @cassandra.stub!(:login!)
    @cassandra.stub!(:keyspace)
    @cassandra.stub!(:keyspace=)
    @cassandra.stub!(:add_keyspace)
    Cassandra.stub!(:new).and_return(@cassandra)
  end

  def mock_column_family
    @column_family = mock(Cassandra::ColumnFamily)
    @column_family.stub!(:name=)
    @column_family.stub!(:keyspace=)
    @column_family.stub!(:column_type=)
    @column_family.stub!(:comparator_type=)
    @column_family.stub!(:subcomparator_type=)
    Cassandra::ColumnFamily.stub!(:new).and_return(@column_family)
  end

  before(:each) do
    Constellation::DataStore.reset_instance
    @data_store = Constellation::DataStore.instance
  end

  describe "#establish_connection" do
    before(:each) do
      mock_server
    end

    it "should load the default configuration" do
      @data_store.should_receive(:default_configuration)
      @data_store.establish_connection
    end

    it "should create a new Cassandra instance" do
      Cassandra.should_receive(:new).and_return(@cassandra)
      @data_store.establish_connection
    end

    it "should confirm about the established connection" do
      Constellation::UserInterface.should_receive(:confirm)
      @data_store.establish_connection
    end

    context "given keyspace does not exist" do
      before(:each) do
        @cassandra.stub!(:keyspace=).and_raise(Cassandra::AccessError)
      end

      it "should create a new keyspace" do
        @cassandra.should_receive(:add_keyspace)
        begin
          @data_store.establish_connection
        # There gets actually no keyspace created
        rescue Cassandra::AccessError
        end
      end

      it "should create new column families" do
        column_family           = Cassandra::ColumnFamily.new
        column_family.keyspace  = @data_store.keyspace
        column_family.name      = "logs"
        @data_store.should_receive(:create_column_families).and_return([column_family])
        begin
          @data_store.establish_connection
        # There gets actually no keyspace created
        rescue Cassandra::AccessError
        end
      end
    end
  end

  describe "#delete" do
    before(:each) do
      mock_server
      @data_store.instance_variable_set("@server", @cassandra)
      @log_entry = Constellation::LogEntry.new("Sep 17 17:02:02 www1 php5: I failed.")
    end

    it "should delete the given log entry including its indexes" do
      @cassandra.should_receive(:remove).exactly(4).times
      @data_store.delete(@log_entry)
    end
  end

  describe "#clear" do
    before(:each) do
      mock_server
      @data_store.instance_variable_set("@server", @cassandra)
    end

    it "should clear all keyspaces" do
      @cassandra.should_receive(:clear_keyspace!)
      @data_store.clear
    end
  end

  describe "#insert" do
    before(:each) do
      mock_server
      @data_store.instance_variable_set("@server", @cassandra)
    end

    context "given log entry is valid" do
      before(:each) do
        @log_entry = Constellation::LogEntry.new("Sep 17 17:02:02 www1 php5: I failed.")
      end

      it "should insert the log entry including its indexes into the database" do
        @cassandra.should_receive(:insert).exactly(4).times
        @data_store.insert(@log_entry)
      end
    end

    context "given log entry is not valid" do
      before(:each) do
        @log_entry = Constellation::LogEntry.new("Sep 17 17:02:02 php5: Fail.")
      end

      it "should raise an InvalidLogFormatError" do
        expect { @data_store.insert(@log_entry) }.to raise_error(Constellation::InvalidLogFormatError)
      end
    end
  end

  describe "#get" do
    before(:each) do
      mock_server
      @data_store.instance_variable_set("@server", @cassandra)
    end

    it "should delegate the method call to @server" do
      @cassandra.should_receive(:get)
      @data_store.get(:logs, '123abc-321def-576awe')
    end
  end

  describe "#get_range" do
    before(:each) do
      mock_server
      @data_store.instance_variable_set("@server", @cassandra)
    end

    it "should delegate the method call to @server" do
      @cassandra.should_receive(:get_range)
      @data_store.get_range(:logs)
    end
  end

  describe "#create_column_families" do
    before(:each) do
      mock_column_family
    end

    it "should create a column family for logs" do
      @column_family.should_receive(:name=).with("logs")
      @data_store.create_column_families
    end

    it "should create a super column family" do
      @column_family.should_receive(:column_type=).with("Super")
      @data_store.create_column_families
    end

    it "should compare the column names by time UUID" do
      @column_family.should_receive(:comparator_type=).with("TimeUUIDType")
      @data_store.create_column_families
    end

    it "should call #create_sorting_column_family three times" do
      @data_store.should_receive(:create_sorting_column_family).exactly(3).times
      @data_store.create_column_families
    end
  end

  describe "#create_sorting_column_family" do
    before(:each) do
      mock_column_family
    end

    it "should create a new Cassandra column family" do
      Cassandra::ColumnFamily.should_receive(:new)
      @data_store.create_sorting_column_family("application")
    end

    it "should create a super column family" do
      @column_family.should_receive(:column_type=).with("Super")
      @data_store.create_sorting_column_family("application")
    end

    it "should use UTF8Type as comparator" do
      @column_family.should_receive(:comparator_type=).with("UTF8Type")
      @data_store.create_sorting_column_family("application")
    end

    it "should use TimeUUIDType as subcomparator" do
      @column_family.should_receive(:subcomparator_type=).with("TimeUUIDType")
      @data_store.create_sorting_column_family("application")
    end

    it "should set the given keyspace" do
      @column_family.should_receive(:keyspace=).with(@data_store.keyspace)
      @data_store.create_sorting_column_family("application")
    end
  end

end
