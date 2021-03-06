module Constellation
  #
  # Constellation::Reader observes the given log files for changes and inserts new entries
  # into the data store.
  #
  class Reader
    attr_accessor :debug_mode

    def initialize(config)
      @config     = config
      @debug_mode = false
      @running    = true
      @threads    = []
    end

    #
    # Starts observing the given files
    #
    def start
      Constellation::UserInterface.inform(">> Starting file observation", :prepend_newline => true)

      @config.watched_files.each { |file|
        @threads << Thread.new { read_log_entries(file) }
      }

      wait_for_interrupt
    end

    #
    # Read the given log file every TIME_TO_WAIT seconds
    #
    def read_log_entries(file)
      begin
        file = File.open(file, "a+")
      rescue Errno::EACCES
        Constellation::UserInterface.error("Permission denied: Please check the access permissions of #{file}", :prepend_newline => true)
        quit_application
      end

      while(@running)
        begin
          while(line = file.readline)
            begin
              log_entry = Constellation::LogEntry.new(line)
              @config.data_store.insert(log_entry)
              Constellation::UserInterface.inform(Time.now.strftime("%m/%d/%Y %I:%M%p") + ":" + log_entry.inspect) if @debug_mode
            rescue Exception => e
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
      log_entry.message     = "A new exception got raised: #{error.to_s}"
      log_entry.key         = "#{log_entry.time.year}/#{log_entry.time.month}/#{log_entry.time.day}/#{log_entry.time.hour}"
      @config.data_store.insert(log_entry)
      Constellation::UserInterface.error(log_entry.message) if @debug_mode
    end

    #
    # Wait until the user quits Constellation
    #
    def wait_for_interrupt
      while(@running)
        sleep(100)
      end
    end

    #
    # Quit the application by killing all opened threads and the process itself.
    #
    def quit_application()
      # Kill each thread except the current thread
      @threads.each { |t| t.kill unless t.object_id==Thread.current.object_id }
      Constellation::UserInterface.confirm("Quitting constellation..", :prepend_newline => true)
      Kernel.exit(1)
    end
  end
end
