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