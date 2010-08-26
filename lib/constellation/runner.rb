require "thor"

module Constellation

  class Runner < Thor
    include Thor::Actions

    @@config = Config.new

    def initialize(*)
      super
    end

    desc "init", "Generates a ConstellationFile and initializes the application"
    def init
      puts "Initializing new application"
    end

    desc "start", "Starts watching for log entries"
    def start
    end

    desc "stop", "Stops watching for log entries"
    def stop
    end

    desc "restart", "Restarts watching for log entries"
    def restart
    end

    desc "version", "Show constellation's version"
    def version
      puts ::Constellation::VERSION
    end
  end

end