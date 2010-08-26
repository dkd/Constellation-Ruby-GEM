module Constellation

  #
  # Constellation::Config is used for evaluating the ConstellationFile
  #
  class Config

    def initialize
      # Includes each file, that should be watched by Constellation
      # Insert a file in this list by using Config.watch
      @watched_files = []
      @data_store    = {}
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

    # Used as wrapper for several configuration options used for setting up the data store
    #
    # Example usage:    data_store.adapter = :cassandra
    #
    def data_store
      self
    end

    # Defines the used database adapter
    #
    # Example usage:    data_store.adapter = :cassandra
    #
    def adapter=(adapter)
      @data_store[:adapter] = adapter.to_s
    end

    # Defines the used database host
    #
    # Example usage:    data_store.host = "127.0.0.1"
    #
    def host=(host)
      @data_store[:host] = host.to_s
    end

    # Defines the username used for authentication
    #
    # Example usage:    data_store.username = "admin"
    #
    def username=(username)
      @data_store[:username] = username
    end

    # Defines the password used for authentication
    #
    # Example usage:    data_store.password = "secret"
    #
    def password=(password)
      @data_store[:password] = password
    end

    # Defines the used namespace
    #
    # Example usage:    data_store.namespace = :my_app
    #
    def namespace=(namespace)
      @data_store[:namespace] = namespace.to_s
    end

  end

end