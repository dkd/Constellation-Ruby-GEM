require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Runner do

  before(:each) do
    @runner = Constellation::Runner.new
  end

  describe "#init" do
    context "a ConstellationFile already exists" do
      it "should raise an error" do
        File.open("ConstellationFile", 'w') {|f| f.write("") }
        lambda {
          @runner.init
        }.should raise_exception
        File.delete("ConstellationFile")
      end
    end
    it "should load the application from the Git repository given by Constellation::REPOSITORY tagged by Constellation::VERSION"

    context "given an error while loading the application" do
      it "should throw an error"
    end
  end

  describe "#help" do
    it "should put some help to the command line" do
      @runner.stub!(:puts)
      @runner.should_receive(:puts)
      @runner.help
    end
  end

  describe "#start" do
    it "should load the config defined at the ConstellationFile"
    it "should establish a connection to the given data store"

    context "given a successful data store connection" do
      it "should start the web application"
    end

    context "given a failed data store connection" do
      it "should throw an error"
    end
  end

  describe "#version" do
    it "should put the current version on the command line" do
      @runner.stub!(:puts)
      @runner.should_receive(:puts).with(Constellation::VERSION)
      @runner.version
    end
  end

end