require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Runner do

  before(:each) do
    @runner = Constellation::Runner.new
  end

  describe "#init" do

    context "ConstellationFile already exists" do
      it "should raise an error" do
        File.open("ConstellationFile", 'w') {|f| f.write("") }
        lambda { @runner.init }.should raise_exception
        File.delete("ConstellationFile")
      end
    end

    context "ConstellationFile does not exist" do
      it "should load the application from the Git repository given by Constellation::REPOSITORY tagged by Constellation::VERSION"
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
    before(:each) do
      # don't wait for file changes
      @runner.instance_variable_get("@reader").instance_variable_get("@monitor").stub!(:run)
    end

    context "ConstellationFile does not exist" do
      it "should raise an error" do
        lambda { @runner.start }.should raise_error
      end
    end

    context "ConstellationFile does exist" do

      before(:each) do
        FileHelpers::create_file("ConstellationFile","watch 'logs.txt'")
        FileHelpers::create_file("logs.txt")
      end

      after(:each) do
        FileHelpers::destroy_file("ConstellationFile")
        FileHelpers::destroy_file("logs.txt")
      end

      context "valid ConstellationFile" do

        it "should load the config defined at the ConstellationFile" do
          File.should_receive(:read).and_return("watch 'logs.txt'")
          @runner.start
        end

        context "given a successful data store connection" do
          it "should start the web application"
        end

        context "given a failed data store connection" do
          it "should throw an error"
        end

      end

      context "invalid ConstellationFile" do
        it "should raise an error" do
          FileHelpers::create_file("ConstellationFile","watch 'logs.txt")
          lambda { @runner.start }.should raise_error
        end
      end

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