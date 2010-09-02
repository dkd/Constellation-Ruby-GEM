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
    # If the given keyspace doesn't exist, a new keyspace including the necessary
    # column families will be created
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
        keyspace                      = Cassandra::Keyspace.new
        keyspace.name                 = @keyspace
        keyspace.strategy_class       = "org.apache.cassandra.locator.RackUnawareStrategy"
        keyspace.replication_factor   = @replication_factor
        keyspace.cf_defs              = create_column_families
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

    protected

    def create_column_families
      families = []
      log_family                 = Cassandra::ColumnFamily.new
      log_family.table           = @keyspace
      log_family.name            = "logs"
      families                   << log_family
      families
    end
  end

end