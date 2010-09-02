require 'fssm'

module Constellation

  #
  # Constellation::Reader observes the given log files for changes and inserts new entries
  # into the data store
  #
  class Reader

    def initialize(config)
      @files      = []
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
          update { |base, relative|
            puts "Change detected (#{file}): Base: #{base} Relative:#{relative}"
          }
        end
      }

      puts ""
      puts ">> Starting file observation"
      @monitor.run
    end
  end

end