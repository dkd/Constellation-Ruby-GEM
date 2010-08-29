require "cassandra/0.7"

module Constellation

  #
  # Constellation::DataStore is used for saving the read log entries
  #
  class DataStore
    attr_accessor :host, :username, :password, :keyspace

    #
    # Establishes a new connection to the given Cassandra store.
    # The Cassandra store gets defined by ConstellationFile.
    #
    def establish_connection
      @server = Cassandra.new(@keyspace, @host)
      @server.login!(@username, @password) if @username && @password
    end

    def host=(host)
      @host = host.to_s
    end

    def keyspace=(keyspace)
      @keyspace = keyspace.to_s
    end

    def username=(username)
      @username = username.to_s
    end
  end

end