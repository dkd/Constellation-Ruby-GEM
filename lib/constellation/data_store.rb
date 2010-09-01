require 'cassandra/0.7'

module Constellation

  #
  # Constellation::DataStore is used for saving the read log entries
  #
  class DataStore
    attr_accessor :host, :username, :password, :keyspace, :port, :replication_factor

    #
    # Establishes a new connection to the given Cassandra store.
    # The Cassandra store gets defined by ConstellationFile.
    #
    def establish_connection
      @host               ||= "127.0.0.1"
      @port               ||= 9160
      @keyspace           ||= "Constellation"
      @replication_factor ||= 1

      @server = Cassandra.new("system", "#{@host}:#{@port.to_s}")
      @server.login!(@username, @password) if @username && @password
      begin
        @server.keyspace = @keyspace
      rescue Cassandra::AccessError
        keyspace = Cassandra::Keyspace.new
        keyspace.name                 = @keyspace
        keyspace.strategy_class       = "org.apache.cassandra.locator.RackUnawareStrategy"
        keyspace.replication_factor   = @replication_factor
        keyspace.cf_def               = []
        @server.add_keyspace(keyspace)
      end
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