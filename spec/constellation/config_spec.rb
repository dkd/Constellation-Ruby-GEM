require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Config do

  before(:each) do
    @config = Constellation::Config.new
  end

  describe "#watch" do
    before(:each) do
      @file_name = "LogFile.txt"
      FileHelpers::create_file(@file_name)
    end
    after(:each) do
      FileHelpers::destroy_file(@file_name)
    end

    context "given a file, that does exist" do
      it "should add the file to the list of watched files" do
        @config.watch(@file_name)
        @config.instance_variable_get("@watched_files").should include(@file_name)
      end
    end

    context "given a file, that has added twice to the watched files list" do
      it "should raise an error" do
        lambda {
          @config.watch(@file_name)
          @config.watch(@file_name)
        }.should raise_exception
      end
    end

    context "given a file, that does not exist" do
      it "should raise an error" do
        lambda {
          @config.watch("DummyLogFile.txt")
        }.should raise_exception
      end
    end
  end

  describe "#freeze!" do
    it "should initialize a new DataStore object" do
      @config.data_store.adapter = :cassandra
      @data_store_mock = mock(Constellation::DataStores::Cassandra)
      @data_store_mock.stub!(:host=)
      @data_store_mock.stub!(:username=)
      @data_store_mock.stub!(:password=)
      @data_store_mock.stub!(:adapter=)
      @data_store_mock.stub!(:namespace=)
      Constellation::DataStores::Cassandra.should_receive(:new).and_return(@data_store_mock)
      @config.freeze!
    end
  end

  describe "#data_store" do

    describe "#adapter=" do
      it "should set the used data_store adapter" do
        @config.data_store.adapter = :cassandra
        @data_store = @config.instance_variable_get("@data_store")
        @data_store[:adapter].should eql("cassandra")
      end
    end

    describe "#host=" do
      it "should set the used data_store host" do
        @config.data_store.host = :localhost
        @data_store = @config.instance_variable_get("@data_store")
        @data_store[:host].should eql("localhost")
      end
    end

    describe "#namespace=" do
      it "should set the used data_store namespace" do
        @config.data_store.namespace = :constellation
        @data_store = @config.instance_variable_get("@data_store")
        @data_store[:namespace].should eql("constellation")
      end
    end

    describe "#user=" do
      it "should set the used data_store user" do
        @config.data_store.username = "admin"
        @data_store = @config.instance_variable_get("@data_store")
        @data_store[:username].should eql("admin")
      end
    end

    describe "#password=" do
      it "should set the used data_store password" do
        @config.data_store.password = "secret"
        @data_store = @config.instance_variable_get("@data_store")
        @data_store[:password].should eql("secret")
      end
    end

  end
end