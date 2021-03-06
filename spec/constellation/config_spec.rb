require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Config do

  before(:each) do
    Constellation::Config.reset_instance
    @config = Constellation::Config.instance
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
      it "should raise an LogFileAlreadyIncludedError" do
        expect {
          @config.watch(@file_name)
          @config.watch(@file_name)
        }.to raise_error(Constellation::LogFileAlreadyIncludedError)
      end
    end

    context "given a file, that does not exist" do
      it "should raise an LogFileNotFoundError" do
        expect { @config.watch("DummyLogFile.txt") }.to raise_error(Constellation::LogFileNotFoundError)
      end
    end
  end

  describe "#data_store" do

    describe "#host=" do
      it "should set the used data_store host" do
        @config.data_store.host = :localhost
        @data_store = @config.instance_variable_get("@data_store")
        @data_store.host.should eql("localhost")
      end
    end

    describe "#keyspace=" do
      it "should set the used data_store keyspace" do
        @config.data_store.keyspace = :constellation
        @data_store = @config.instance_variable_get("@data_store")
        @data_store.keyspace.should eql("constellation")
      end
    end

    describe "#user=" do
      it "should set the used data_store user" do
        @config.data_store.username = "admin"
        @data_store = @config.instance_variable_get("@data_store")
        @data_store.username.should eql("admin")
      end
    end

    describe "#password=" do
      it "should set the used data_store password" do
        @config.data_store.password = "secret"
        @data_store = @config.instance_variable_get("@data_store")
        @data_store.password.should eql("secret")
      end
    end

    describe "#port=" do
      it "should set the used data_store port" do
        @config.data_store.port = 9160
        @data_store = @config.instance_variable_get("@data_store")
        @data_store.port.should eql(9160)
      end
    end

  end
end