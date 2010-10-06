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
      @config.watched_files.each { |file|
        puts "Watching for changes of #{file}"
        @monitor.path(Dir.pwd, file) do
          # open the file in read-only-mode pointing
          @file = File.open(file, (::File::RDONLY|::File::TRUNC))
          @config = Config.instance
          # read new log entries everytime the file gets updated
          # and insert them into the data store
          update { |base, relative|
            Reader::read_log_entries(@config, @file)
          }

        end
      }

      puts ""
      puts ">> Starting file observation"
      @monitor.run
    end

    class << self

      def read_log_entries(config, file)
        begin
          while(line = file.readline)
            log_entry = LogEntry.new(line)
            config.data_store.insert(log_entry)
          end
        # rescue from several errors that may occur due to an invalid log format
        # but should not appear in order to avoid performance issues
        rescue FSSM::CallbackError => e
          new_system_exception(config, e)
        rescue EOFError => e
          new_system_exception(config, e)
        rescue Constellation::InvalidLogFormatError => e
          new_system_exception(config, e)
        end
      end

      def new_system_exception(config, exception)
        log_entry             = Constellation::LogEntry.new
        log_entry.machine     = "system"
        log_entry.application = "Constellation"
        log_entry.timestamp   = Time.now.to_i
        log_entry.message     = "A new exception got raised: #{exception.inspect}"
        config.data_store.insert(log_entry)
      end

    end

  end

end