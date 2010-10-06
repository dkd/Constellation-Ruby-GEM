require 'cassandra/0.7'

module Constellation

  #
  # Constellation::DataStore is used for saving the read log entries in Cassandra.
  #
  # == Default configuration
  #
  #   Host                = 127.0.0.1
  #   Port                = 9160
  #   Keyspace            = Constellation
  #   Replication Factor  = 1
  #
  #
  #
  # Constellation uses some keyspaces by default.
  #
  # == Default keyspaces
  #
  #   logs
  #
  class DataStore
    attr_accessor :host, :username, :password, :keyspace, :port, :replication_factor

    #
    # Establishes a new connection to the given Cassandra store.
    # The Cassandra store gets defined by ConstellationFile.
    #
    # If the given keyspace doesn't exist, a new keyspace including the necessary
    # column families will be created.
    # It is recommended to use a not existing keyspace in order to make sure that the data model
    # is set up correctly.
    #
    def establish_connection
      @host               ||= "127.0.0.1"
      @port               ||= 9160
      @keyspace           ||= "Constellation"
      @replication_factor ||= 1

      # connect to the system keyspace initially in order to establish a working connection
      @server = Cassandra.new("system", "#{@host}:#{@port.to_s}")
      @server.login!(@username, @password) if @username && @password
      begin
        @server.keyspace = @keyspace
      rescue Cassandra::AccessError
        keyspace                      = Cassandra::Keyspace.new
        keyspace.name                 = @keyspace
        keyspace.strategy_class       = "org.apache.cassandra.locator.SimpleStrategy"
        keyspace.replication_factor   = @replication_factor
        keyspace.cf_defs              = create_column_families
        @server.add_keyspace(keyspace)
      end
      puts "Connection to the Cassandra store (#{@host}:#{@port.to_s}) got established."
    end

    #
    # Inserts the given log entry into the database.
    #
    def insert(log_entry)
      raise InvalidLogFormatError unless log_entry.valid?
      @server.insert(:logs, log_entry.to_h['uuid'], log_entry.to_h)
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

    #
    # Creates the necessary column families:
    #
    # * logs
    #
    def create_column_families
      families = []
      log_family            = Cassandra::ColumnFamily.new
      log_family.keyspace   = @keyspace
      log_family.name       = "logs"
      families              << log_family
      families
    end
  end

end