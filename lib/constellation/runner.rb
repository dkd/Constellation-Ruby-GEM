require 'thor'

module Constellation

  #
  # Constellation::Runner handles several commands, initializes a new project, starts a project or prints the currently installed
  # Constellation version
  #
  class Runner < Thor
    include Thor::Actions

    def initialize(*)
      super
      @config = Config.instance
      @reader = Reader.new(@config)
    end

    desc "init", "Generates a ConstellationFile and initializes the application"
    def init
      raise ConstellationFileAlreadyExistsError if File.exists?("ConstellationFile")
      puts "Initializing new application.."
      puts ""
      puts "The configuration can be found in ConstellationFile"
      create_example_constellation_file
    end
    map %w(-i) => :start

    desc "start", "Starts watching for log entries"
    def start
      raise ConstellationFileNotFoundError unless File.exists?("ConstellationFile")

      begin
        @config.instance_eval(File.read("ConstellationFile"))
      rescue SyntaxError
        raise Constellation::InvalidConstellationFileError
      end
      @config.data_store.establish_connection

      # start the log file watching threads in the background
      @reader.start
    end
    map %w(-s) => :start

    desc "version", "Shows the version of the currently installed Constellation gem"
    def version
      puts VERSION
    end
    map %w(-v --version) => :version

    desc "help", "Shows the example usage of all available command line options"
    def help
      puts "Available command line options:"
      puts ""
      puts "constellation init        Generates a ConstellationFile and initializes the application"
      puts "constellation start       Starts watching for log entries"
      puts "constellation version     Shows the version of the currently installed Constellation gem"
      puts "constellation help        Shows the example usage of all available command line options"
    end
    map %w(--help) => :help

    no_tasks{
      #
      # Creates a new ConstellationFile and fills it with example configuration.
      #
      def create_example_constellation_file
        File.open("ConstellationFile", 'w') {|f|
          f.write <<-END.gsub(/^ {10}/, '')
          # Adds the file 'syslog' to the list of watched log files
          watch "/var/log/syslog"

          # Wait 2 seconds between scanning the log file for new log entries
          reading_buffer = 2

          # Define the connection to the Cassandra server
          data_store.host     = "127.0.0.1"
          data_store.port     = 9160
          data_store.keyspace = :constellation
          # Set username and password, if needed
          # data_store.username = :admin
          # data_store.password = "secret"
          END
        }
      end
    }
  end

end