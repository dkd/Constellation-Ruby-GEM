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
      @config.freeze!
      @config.instance_variable_get("@data_store").should be_a(Constellation::DataStore)
    end
  end

  describe "#data_store" do

    describe "#host=" do
      it "should set the used data_store host" do
        @config.data_store.host = :localhost
        @data_store = @config.instance_variable_get("@data_store")
        @data_store[:host].should eql("localhost")
      end
    end

    describe "#keyspace=" do
      it "should set the used data_store keyspace" do
        @config.data_store.keyspace = :constellation
        @data_store = @config.instance_variable_get("@data_store")
        @data_store[:keyspace].should eql("constellation")
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