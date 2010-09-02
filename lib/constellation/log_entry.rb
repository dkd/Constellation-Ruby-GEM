module Constellation

  #
  # Represents a log entry having the following attributes:
  # * uuid (key)
  # * machine
  # * application
  # * message
  # * timestamp
  #
  class LogEntry
    attr_accessor :machine, :application, :message, :timestamp
  end

end