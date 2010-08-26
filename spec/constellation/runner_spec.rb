require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Runner do

  describe "#run!" do
  end

  describe "#init" do
    it "should load the application from the Git repository given by Constellation::REPOSITORY tagged by Constellation::VERSION"

    context "given an error while loading the application" do
      it "should throw an error"
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

  describe "#restart" do
    it "should call #stop"
    it "should call #start"
  end

  describe "#stop" do
    it "should close the connection"
  end

  describe "#version" do
    it "should put the current version on the command line"
  end

end