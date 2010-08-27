require "thor"

module Constellation

  class Runner < Thor
    include Thor::Actions

    def initialize(*)
      super
      @config = Config.new
    end

    desc "init", "Generates a ConstellationFile and initializes the application"
    def init
      raise ConstellationFileAlreadyExists if File.exists?("ConstellationFile")
      puts "Initializing new application"
    end
    map %w(-i) => :start

    desc "start", "Starts watching for log entries"
    def start
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