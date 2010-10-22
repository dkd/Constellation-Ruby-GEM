module Constellation

  #
  # Constellation::Reader observes the given log files for changes and inserts new entries
  # into the data store.
  #
  class Reader
    def initialize(config)
      @config     = config
      @running    = true
      @threads    = []
    end

    #
    # Starts observing the given files
    #
    def start
      puts ""
      puts ">> Starting file observation"

      @config.watched_files.each { |file|
        @threads << Thread.new {
          read_log_entries(file)
        }
      }

      puts ""
      puts "Enter CTRL+c to quit Constellation"
      wait_for_interrupt
    end

    #
    # Read the given log file every TIME_TO_WAIT seconds
    #
    def read_log_entries(file)
      begin
        file = File.open(file, "a+")
      rescue Errno::EACCES
        puts ""
        puts "Permission denied: Please check the access permissions of #{file}"
        quit_application
      end

      while(@running)

        begin
          while(line = file.readline)
            log_entry = LogEntry.new(line)
            begin
              @config.data_store.insert(log_entry)
            rescue Constellation::InvalidLogFormatError => e
              new_system_error(e)
            end
          end
        # rescue from several errors that may occur due to an invalid log format
        # but should not appear in order to avoid performance issues
        rescue EOFError => e
        end

        sleep(@config.reading_buffer)
      end
    end

    #
    # Log errors that get raised while reading the log file
    #
    def new_system_error(error)
      log_entry             = Constellation::LogEntry.new
      log_entry.machine     = "system"
      log_entry.application = "Constellation"
      log_entry.time        = Time.now
      log_entry.message     = "A new exception got raised: #{error.inspect}"
      @config.data_store.insert(log_entry)
    end

    #
    # Wait until the user quits Constellation
    #
    def wait_for_interrupt
      while(true)
        sleep(100)
      end
    rescue Interrupt
      @running = false
      # wait until all threads are terminated
      quit_application
    end

    #
    # Quit the application by killing all opened threads and the process itself
    #
    def quit_application
      @threads.each { |t| t.join }
      puts ""
      puts "Quitting constellation.."
      Kernel.exit(1)
    end
  end

end