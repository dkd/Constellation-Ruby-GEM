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
      @config = Config.new
    end

    desc "init", "Generates a ConstellationFile and initializes the application"
    def init
      raise ConstellationFileAlreadyExistsError if File.exists?("ConstellationFile")
      puts "Initializing new application"
    end
    map %w(-i) => :start

    desc "start", "Starts watching for log entries"
    def start
      raise ConstellationFileNotFoundError unless File.exists?("ConstellationFile")

      @config.instance_eval(File.read("ConstellationFile"))
      @config.data_store.establish_connection
    end
    map %w(-s) => :start

    desc "version", "Shows the version of the currently installed Constellation gem"
    def version
      puts ::Constellation::VERSION
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
  end

end