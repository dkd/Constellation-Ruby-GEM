require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Config do

  before(:each) do
    @config = Constellation::Config.new
  end

  describe "#watch" do
    context "given a file, that does exist" do
      it "should add the file to the list of watched files" do

      end
    end

    context "given a file, that does not exist" do
      it "should throw an error"
    end

    context "given a file, that does not fit the neccessary permissions" do
      it "should throw an error"
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