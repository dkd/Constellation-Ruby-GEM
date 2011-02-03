require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constellation::Runner do

  before(:each) do
    @data_store = mock(Constellation::DataStore)
    @data_store.stub!(:establish_connection)
    @runner = Constellation::Runner.new
    @runner.instance_variable_get("@config").stub!(:data_store).and_return(@data_store)
  end

  describe "#init" do

    context "ConstellationFile already exists" do
      it "should raise an error" do
        File.open("ConstellationFile", 'w') {|f| f.write("") }
        expect { @runner.init }.to raise_exception
        File.delete("ConstellationFile")
      end
    end

    context "ConstellationFile does not exist" do
      it "should create a new ConstellationFile" do
        @runner.init
        File.should exist("ConstellationFile")
        File.delete("ConstellationFile")
      end
    end

  end

  describe "#help" do
    it "should put some help to the command line" do
      Constellation::UserInterface.should_receive(:inform).exactly(6).times
      @runner.help
    end
  end

  describe "#start" do
    before(:each) do
      # don't wait for file changes
      @reader = @runner.instance_variable_get("@reader")
      @reader.stub!(:start)
      @reader.stub!(:wait_for_quit)
      @thread = mock(Titan::Thread)
      @thread.stub!(:run)
      Titan::Thread.stub!(:new).and_return(@thread)
      File.stub!(:read).and_return("")
			File.stub!(:exists?).and_return(true)
    end

		context "given a config file" do
			it "should use it instead of the default file" do
				file_name = "test.rb"
				File.should_receive(:expand_path).with(file_name).and_return(file_name)
				@runner.start(file_name)
			end
		end

		context "given no config file" do
			it "should use ConstellationFile" do
				File.should_receive(:expand_path).with("ConstellationFile")
				@runner.start
			end
		end

    context "given the --debug option" do
      before(:each) do
        @options = { :debug => true }
        @runner.stub!(:options).and_return(@options)
        @config = @runner.instance_variable_get("@config")
        Constellation::DataStore.instance.stub!(:establish_connection)
      end

      it "should active the reader's debug mode" do
        @reader.should_receive(:debug_mode=).with(true)
        @runner.start
      end
    end

    context "ConstellationFile does not exist" do
			before(:each) do
				File.stub!(:exists?).and_return(false)
			end

      it "should raise an ConstellationFileNotFoundError" do
        expect { @runner.start }.to raise_error(Constellation::ConstellationFileNotFoundError)
      end
    end

    context "ConstellationFile does exist" do
      before(:each) do
        File.stub(:exists?).and_return(true)
      end

      context "valid ConstellationFile" do
        before(:each) do
          File.stub!(:read).and_return("")
        end

        it "should load the config defined at the ConstellationFile" do
          File.should_receive(:read).and_return("watch 'logs.txt'")
          @runner.start
        end

        it "should start a new Titan thread" do
          @thread.should_receive(:run)
          @runner.start
        end

        context "given a failed data store connection" do
          before(:each) do
            @data_store.stub!(:establish_connection).and_raise(Constellation::ConnectionFailedError)
          end

          it "should throw an ConnectionFailedError" do
            expect { @runner.start }.to raise_error(Constellation::ConnectionFailedError)
          end
        end

      end

      context "invalid ConstellationFile" do
				before(:each) do
					File.stub!(:read).and_return("watch 'logs.txt")
				end

        it "should raise an InvalidConstellationFileError" do
          expect { @runner.start }.to raise_error(Constellation::InvalidConstellationFileError)
        end
      end

    end
  end

  describe "#stop" do
    it "should search for the Constellation process" do
      Titan::Thread.should_receive(:find).and_return(nil)
      @runner.stop
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
