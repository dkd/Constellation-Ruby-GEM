module Constellation

  class Config

    def initialize
      # Includes each file, that should be watched by Constellation
      # Insert a file in this list by using Config.watch
      @watched_files = []
    end

  end

end