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
      @data_store    = {:username => nil, :password => nil, :keyspace => "constellation", :host => "localhost"}
    end

    # Adds a new log file to the watched files list, that gets observer for changes.
    #
    # Example usage:    watch "logs._txt"
    #
    def watch(file_name)
      raise LogFileNotFoundError    unless File::exists?(file_name)
      raise LogFileAlreadyIncluded  if @watched_files.include?(file_name)
      @watched_files << file_name
    end

    # Used as wrapper for several configuration options used for setting up the data store
    #
    # Example usage:    data_store.adapter = :cassandra
    #
    def data_store
      @data_store.is_a?(Hash) ? self : @data_store
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

    # Defines the used keyspace
    #
    # Example usage:    data_store.keyspace = :my_app
    #
    def keyspace=(keyspace)
      @data_store[:keyspace] = keyspace.to_s
    end

    #
    # Freezes the current config setup and creates a new DataStore object using the informations of the @data_store Hash
    #
    def freeze!
      data_store  = DataStore.new
      data_store.host       = @data_store[:host]
      data_store.username   = @data_store[:username]
      data_store.password   = @data_store[:password]
      data_store.keyspace  = @data_store[:keyspace]
      @data_store = data_store
    end

  end

end