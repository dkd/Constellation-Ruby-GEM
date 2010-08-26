require "bundler/setup"
require "constellation/version"

module Constellation

  autoload :Config,       "constellation/config"
  autoload :DataStore,    "constellation/data_store"
  autoload :DataStores,   "constellation/data_stores"
  autoload :Reader,       "constellation/reader"
  autoload :Runner,       "constellation/runner"

  class ConstellationError < StandardError
  end

  class ConstellationFileNotFoundError  < ConstellationError;   end
  class LogFileNotFoundError            < ConstellationError;   end
  class LogFileAlreadyIncluded          < ConstellationError;   end
  class InvalidCommandLineOptionError   < ConstellationError;   end
  class InvalidConstellationFileError   < ConstellationError;   end
  class InvalidLogFormatError           < ConstellationError;   end

end