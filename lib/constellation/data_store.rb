require 'cassandra/0.7'
require 'singleton'

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
    include ::Singleton
    attr_accessor :host, :username, :password, :keyspace, :port, :replication_factor

    #
    # Loads the default configuration
    #
    def default_configuration
      @host               ||= "127.0.0.1"
      @port               ||= 9160
      @keyspace           ||= "Constellation"
      @replication_factor ||= 1
    end

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
      default_configuration

      # connect to the system keyspace initially in order to establish a working connection
      @server = Cassandra.new("system", "#{@host}:#{@port.to_s}")
      @server.login!(@username, @password) if @username && @password
      begin
        @server.keyspace = @keyspace
      rescue Cassandra::AccessError
        @server.add_keyspace(create_keyspace)
        @server.keyspace = @keyspace
      rescue CassandraThrift::Cassandra::Client::TransportException
        raise Constellation::ConnectionFailedError
      end
      puts "Connection to the Cassandra store (#{@host}:#{@port.to_s}) got established."
    end

    #
    # Inserts the given log entry into the database.
    #
    def insert(log_entry)
      raise Constellation::InvalidLogFormatError unless log_entry.valid?
      @server.insert(:logs, log_entry.key, log_entry.to_h)
    end

    #
    # Get one single value
    #
    def get(uuid)
      @server.get(:logs, uuid)
    end

    #
    # Get multiple key-value-pairs
    #
    def get_range(options = {})
      @server.get_range(:logs, options)
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
    # Creates the Cassandra keyspace
    #
    def create_keyspace
      keyspace                      = Cassandra::Keyspace.new
      keyspace.name                 = @keyspace
      keyspace.strategy_class       = "org.apache.cassandra.locator.SimpleStrategy"
      keyspace.replication_factor   = @replication_factor
      keyspace.cf_defs              = create_column_families
      keyspace
    end

    #
    # Creates the necessary column families:
    #
    # * logs
    #
    def create_column_families
      families = []
      log_family                    = Cassandra::ColumnFamily.new
      log_family.name               = "logs"
      log_family.keyspace           = @keyspace
      log_family.column_type        = "Super"
      log_family.comparator_type    = "TimeUUIDType"
      families                      << log_family
      families
    end

  end

end