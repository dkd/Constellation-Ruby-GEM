require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Config do

  before(:each) do
    @config = Constellation::Config.new
  end

  describe "#watch" do
    before(:each) do
      @file_name = "LogFile.txt"
      File.open(@file_name, 'w') {|f| f.write("") }
    end
    after(:each) do
      File.delete(@file_name)
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

  describe "#data_store" do

    describe "#adapter=" do
      it "should set the used data_store adapter"
    end

    describe "#host=" do
      it "should set the used data_store host"
    end

    describe "#namespace=" do
      it "should set the used data_store namespace"
    end

    describe "#user=" do
      it "should set the used data_store user"
    end

    describe "#password=" do
      it "should set the used data_store password"
    end

  end
end