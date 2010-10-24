require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::UserInterface do

  before(:each) do
    @message    = "Hi!"
  end

  describe ".inform" do
    it "should print a not colored message" do
      Constellation::UserInterface.should_receive(:put).with(@message, nil, {})
      Constellation::UserInterface.inform(@message)
    end
  end

  describe ".confirm" do
    it "should print a green message" do
      Constellation::UserInterface.should_receive(:put).with(@message, :green, {})
      Constellation::UserInterface.confirm(@message)
    end
  end

  describe ".warn" do
    it "should print a yellow message" do
      Constellation::UserInterface.should_receive(:put).with(@message, :yellow, {})
      Constellation::UserInterface.warn(@message)
    end
  end

  describe ".error" do
    it "should print a red message" do
      Constellation::UserInterface.should_receive(:put).with(@message, :red, {})
      Constellation::UserInterface.error(@message)
    end
  end

  describe ".put" do
    before(:each) do
      @thor_shell = Constellation::UserInterface.__send__("class_variable_get", "@@shell")
    end

    context "given a newline should get prepended" do
      it "should put two messages" do
        @thor_shell.should_receive(:say).twice
        Constellation::UserInterface.put(@message, nil, :prepend_newline => true)
      end
    end
    context "given a newline should not get prepended" do
      it "should put one message" do
        @thor_shell.should_receive(:say).once
        Constellation::UserInterface.put(@message, nil, :prepend_newline => false)
      end
    end
  end

end