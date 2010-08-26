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

    def start
    end

    def stop
    end

    def restart
    end
  end

end