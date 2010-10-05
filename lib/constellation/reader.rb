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

          # read new log entries everytime the file gets updated
          # and insert them into the data store
          update { |base, relative|
            begin
              while(line = @file.readline)
                log_entry = LogEntry.new(line)
              end
            rescue FSSM::CallbackError
            end
          }

        end
      }

      puts ""
      puts ">> Starting file observation"
      @monitor.run
    end
  end

end