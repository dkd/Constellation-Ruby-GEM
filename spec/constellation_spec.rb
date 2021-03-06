require "spec_helper"

describe Constellation do

  describe Constellation::ConstellationError do
    it "should be a kind of StandardError" do
      @constellation_error = Constellation::ConstellationError.new
      @constellation_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::ConnectionFailedError do
    it "should be a kind of ConstellationError" do
      @connection_failed_error = Constellation::ConnectionFailedError.new
      @connection_failed_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::ConstellationFileAlreadyExistsError do
    it "should be a kind of ConstellationError" do
      @constellation_file_already_exists_error = Constellation::ConstellationFileAlreadyExistsError.new
      @constellation_file_already_exists_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::ConstellationFileNotFoundError do
    it "should be a kind of ConstellationError" do
      @file_not_found_error = Constellation::ConstellationFileNotFoundError.new
      @file_not_found_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::InvalidCommandLineOptionError do
    it "should be a kind of ConstellationError" do
      @invalid_command_line_option_error = Constellation::InvalidCommandLineOptionError.new
      @invalid_command_line_option_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::InvalidConstellationFileError do
    it "should be a kind of ConstellationError" do
      @invalid_constellation_file_error = Constellation::InvalidConstellationFileError.new
      @invalid_constellation_file_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::InvalidLogFormatError do
    it "should be a kind of ConstellationError" do
      @invalid_log_format_error = Constellation::InvalidLogFormatError.new
      @invalid_log_format_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::LogFileAlreadyIncludedError do
    it "should be a kind of ConstellationError" do
      @log_file_already_included_error = Constellation::LogFileAlreadyIncludedError.new
      @log_file_already_included_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

  describe Constellation::LogFileNotFoundError do
    it "should be a kind of ConstellationError" do
      @log_file_not_found_error = Constellation::LogFileNotFoundError.new
      @log_file_not_found_error.should be_a_kind_of(Constellation::ConstellationError)
    end
  end

end