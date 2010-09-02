module Constellation

  #
  # Constellation::Config is used for evaluating the ConstellationFile
  #
  class Config

    def initialize
      # Includes each file, that should be watched by Constellation
      # Insert a file in this list by using Config.watch
      @watched_files = []
      # Default values for the data store
      @data_store    = DataStore.new
    end

    # Adds a new log file to the watched files list, that gets observer for changes.
    #
    # Example usage:
    #   watch "logs.txt"
    #
    def watch(file_name)
      raise LogFileNotFoundError    unless File::exists?(file_name)
      raise LogFileAlreadyIncludedError  if @watched_files.include?(file_name)
      @watched_files << file_name
    end

    # Used as wrapper for several configuration options used for setting up the data store
    #
    # Example usage:
    #   data_store.host     = :localhost
    #   data_store.port     = 9160
    #   data_store.username = :admin
    #   data_store.password = "secret"
    #   data_store.keyspace = :constellation
    #
    def data_store
      @data_store
    end

    def watched_files
      @watched_files
    end

  end

end