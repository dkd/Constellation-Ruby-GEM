# By default Rubygems are used as source,
# but you are free to choose your own provider
begin
  require "bundler/setup"
rescue LoadError
  require "rubygems"
  require "bundler/setup"
end
require "constellation/version"

#
# Constellation is a modern, scalable solution for managing your log files
# across several servers and by many users.
#
# It uses the well-known key-value store Cassandra for saving log entries and provides an
# easy-to-use web application, written in Ruby on Rails, for monitoring and controlling.
#
module Constellation

  REPOSITORY            = "ssh://root@git.dkd.de/var/cache/constellation-app.git".freeze

  autoload :Config,       "constellation/config"
  autoload :DataStore,    "constellation/data_store"
  autoload :Reader,       "constellation/reader"
  autoload :Runner,       "constellation/runner"

  class ConstellationError < StandardError
  end

  class ConstellationFileNotFoundError      < ConstellationError;   end
  class ConstellationFileAlreadyExistsError < ConstellationError;   end
  class LogFileNotFoundError                < ConstellationError;   end
  class LogFileAlreadyIncludedError         < ConstellationError;   end
  class InvalidCommandLineOptionError       < ConstellationError;   end
  class InvalidConstellationFileError       < ConstellationError;   end
  class InvalidLogFormatError               < ConstellationError;   end

end