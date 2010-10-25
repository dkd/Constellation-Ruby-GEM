require "thor"

module Constellation
  #
  # Constellation::Runner handles several commands, initializes a new project, starts a project or prints the currently installed
  # Constellation version
  #
  class Runner < Thor
    include Thor::Actions

    def initialize(*)
      super
      @config = Constellation::Config.instance
      @reader = Constellation::Reader.new(@config)
    end

    desc "init", "Generates a ConstellationFile containing initial configuration"
    def init
      raise Constellation::ConstellationFileAlreadyExistsError if File.exists?("ConstellationFile")
      Constellation::UserInterface.inform("Initializing new application..")
      Constellation::UserInterface.inform("The configuration can be found in `ConstellationFile`", :prepend_newline => true)
      create_example_constellation_file
    end
    map %w(-i) => :start

    desc "start", "Starts watching for log entries"
    def start
      raise Constellation::ConstellationFileNotFoundError unless File.exists?("ConstellationFile")
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
      puts Constellation::VERSION
    end
    map %w(-v --version) => :version

    desc "help", "Shows the example usage of all available command line options"
    def help
      Constellation::UserInterface.inform("Available command line options:")
      Constellation::UserInterface.inform("constellation init        Generates a ConstellationFile containing initial configuration", :prepend_newline => true)
      Constellation::UserInterface.inform("constellation start       Starts watching for log entries")
      Constellation::UserInterface.inform("constellation version     Shows the version of the currently installed Constellation gem")
      Constellation::UserInterface.inform("constellation help        Shows the example usage of all available command line options")
    end
    map %w(--help) => :help

    no_tasks{
      #
      # Creates a new ConstellationFile and fills it with example configuration.
      #
      def create_example_constellation_file
        File.open("ConstellationFile", 'w') {|f|
          f.write <<-END.gsub(/^ {10}/, '')
          # Adds the file '/var/log/syslog' to the list of watched log files
          watch "/var/log/syslog"

          # Wait 1 seconds between scanning the log file for new log entries
          reading_buffer = 1

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