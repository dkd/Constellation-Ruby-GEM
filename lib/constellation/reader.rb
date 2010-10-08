require 'fssm'

module Constellation

  #
  # Constellation::Reader observes the given log files for changes and inserts new entries
  # into the data store.
  #
  # It is recommended that you have installed rb-inotify >= 0.5.1 in order to avoid that polling
  # is getting used by FSSM.
  #
  class Reader

    def initialize(config)
      @monitor    = FSSM::Monitor.new
      @config     = config
    end

    #
    # Starts observing the given files for changes using the FSSM gem.
    #
    def start

      puts ""
      puts ">> Starting file observation"

      Reader::read_log_entries(@config, File.open("logs", "a+"))
    end

    class << self

      def read_log_entries(config, file)
        while(true)

          begin
            while(line = file.readline)
              log_entry = LogEntry.new(line)
              begin
                config.data_store.insert(log_entry)
              rescue Constellation::InvalidLogFormatError => e
                new_system_error(config, e)
              end
            end
          # rescue from several errors that may occur due to an invalid log format
          # but should not appear in order to avoid performance issues
          rescue EOFError => e
          rescue FSSM::CallbackError => e
            new_system_error(config, e)
          end

          sleep(2)
        end
      end

      #
      # Log errors that get raised while reading the log file
      #
      def new_system_error(config, error)
        log_entry             = Constellation::LogEntry.new
        log_entry.machine     = "system"
        log_entry.application = "Constellation"
        log_entry.timestamp   = Time.now.to_i
        log_entry.message     = "A new exception got raised: #{error.inspect}"
        config.data_store.insert(log_entry)
      end

    end

  end

end