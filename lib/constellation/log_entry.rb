require "simple_uuid"
require "json"
require "active_model"

module Constellation
  #
  # Represents a log entry having the following attributes:
  #
  # * uuid (key)
  # * machine
  # * application
  # * message
  # * timestamp
  #
  class LogEntry
    include ::ActiveModel::Serialization
    include ::ActiveModel::Validations

    attr_accessor :machine, :application, :message, :time, :key, :uuid

    validates_presence_of :machine, :application, :message, :time, :key

    # Initializes a new log entry by generating a UUID
    def initialize(line_of_log_file=nil)
      @uuid = SimpleUUID::UUID.new
      parse(line_of_log_file) unless line_of_log_file.nil?
    end

    # Parses a given line of a log file and initializes a new
    # LogEntry object.
    #
    # A line of a log file has to fit the following order: Date Machine Application: Message
    # e.g.: Sep  2 17:20:01 www1 ruby: Ruby really rocks!
    def parse(line_of_log_file)
      # The first 15 characters of a log entry describe the time.
      @time             = Time.parse(line_of_log_file[0..14])
      line_of_log_file  = slice_line_from(line_of_log_file, 16)
      # The machine name can include anything but whitespaces
      unless line_of_log_file.nil?
        @machine          = line_of_log_file.scan(/[^\s]+/).first
        line_of_log_file  = slice_line_from(line_of_log_file, @machine.length+1)
      end
      # The application name can include anything but whitespaces
      unless line_of_log_file.nil?
        @application  = line_of_log_file.scan(/[^\s\:]+/).first
        # The rest of the log entry is the message itself.
        @message      = slice_line_from(line_of_log_file, @application.length+2)
        # remove the process id
        @application.gsub!(/\[[0-9]+\]/, "")
      end
      @key = "#{@time.year}/#{@time.month}/#{@time.day}/#{@time.hour}"
    end

    # return a substring starting from the position given in from
    def slice_line_from(line, from)
      line[from..line.length-1]
    end

    # returns a Hash that gets stored in the database
    def to_h
      {
        @uuid => {
          'machine'     => @machine.to_s,
          'application' => @application.to_s,
          'message'     => @message.to_s,
          'timestamp'   => @time.to_i.to_s
        }
      }
    end
  end
end
