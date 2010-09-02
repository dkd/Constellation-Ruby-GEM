require 'uuid'

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

    #
    # Parses a given line of a log file and initializes a new
    # LogEntry object
    #
    def initialize(line_of_log_file)
    end

    def to_json
      {
        :uuid         => UUID.new.generate,
        :machine      => @machine,
        :application  => @application,
        :message      => @message,
        :timestamp    => @timestamp
      }.to_json
    end
  end

end