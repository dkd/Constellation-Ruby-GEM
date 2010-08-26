module Constellation

  class Config

    def initialize
      # Includes each file, that should be watched by Constellation
      # Insert a file in this list by using Config.watch
      @watched_files = []
    end

    # Adds a new log file to the watched files list, that gets observer for changes.
    #
    # Example usage:    watch "logs._txt"
    #
    def watch(file_name)
      raise LogFileNotFoundError unless File::exists?(file_name)
      raise LogFileAlreadyIncluded if @watched_files.include?(file_name)
      @watched_files << file_name
    end

  end

end