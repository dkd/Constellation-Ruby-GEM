require "cassandra/0.7"
require "singleton"

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
  # Constellation uses some column families by default.
  #
  # == Default column families
  #
  # * logs
  # * logs_by_application
  # * logs_by_machine
  # * logs_by_machine_and_application
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
      begin
        @server.login!(@username, @password) if @username && @password
        @server.keyspace = @keyspace
      rescue Cassandra::AccessError
        @server.add_keyspace(create_keyspace)
        @server.keyspace = @keyspace
      rescue CassandraThrift::Cassandra::Client::TransportException
        raise Constellation::ConnectionFailedError
      end
      Constellation::UserInterface.confirm("Connection to the Cassandra store (#{@host}:#{@port.to_s}@#{@keyspace}) got established.")
    end

    #
    # Removes the given log entry including its indexes from the database
    #
    def delete(log_entry)
      @server.remove(:logs, log_entry.key, log_entry.uuid.to_guid)
      @server.remove(:logs_by_application, log_entry.key, log_entry.application, log_entry.uuid.to_guid)
      @server.remove(:logs_by_machine,     log_entry.key, log_entry.machine,     log_entry.uuid.to_guid)
      @server.remove(:logs_by_machine_and_application, log_entry.key+"_"+log_entry.machine, log_entry.application, log_entry.uuid.to_guid)
    end

    #
    # Truncates all column families.
    #
    def clear
      @server.clear_keyspace!
    end

    #
    # Inserts the given log entry into the database and creates indexes.
    #
    def insert(log_entry)
      raise Constellation::InvalidLogFormatError unless log_entry.valid?
      @server.insert(:logs, log_entry.key, log_entry.to_h)
      @server.insert(:logs_by_application, log_entry.key, { log_entry.application => { log_entry.uuid => log_entry.key } })
      @server.insert(:logs_by_machine,     log_entry.key, { log_entry.machine     => { log_entry.uuid => log_entry.key } })
      @server.insert(:logs_by_machine_and_application, log_entry.key+"_"+log_entry.machine, { log_entry.application => { log_entry.uuid => log_entry.key } })
    end

    #
    # Get one single value
    #
    def get(column_family, key, options= {})
      @server.get(column_family, key, options)
    end

    #
    # Get multiple key-value-pairs
    #
    def get_range(column_family, options = {})
      @server.get_range(column_family, options)
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
      keyspace                    = Cassandra::Keyspace.new
      keyspace.name               = @keyspace
      keyspace.strategy_class     = "org.apache.cassandra.locator.SimpleStrategy"
      keyspace.replication_factor = @replication_factor
      keyspace.cf_defs            = create_column_families
      keyspace
    end

    #
    # Creates the necessary column families:
    #
    # * logs
    # * logs_by_application
    # * logs_by_machine
    # * logs_by_machine_and_application
    #
    def create_column_families
      families = []
      log_family                  = Cassandra::ColumnFamily.new
      log_family.name             = "logs"
      log_family.keyspace         = @keyspace
      log_family.column_type      = "Super"
      log_family.comparator_type  = "TimeUUIDType"
      families                    << log_family
      families                    << create_sorting_column_family("application")
      families                    << create_sorting_column_family("machine")
      families                    << create_sorting_column_family("machine_and_application")
      families
    end

    #
    # Creates a new column family that is used for sorting log entries.
    #
    def create_sorting_column_family(attribute)
      log_family                    = Cassandra::ColumnFamily.new
      log_family.name               = "logs_by_#{attribute}"
      log_family.keyspace           = @keyspace
      log_family.column_type        = "Super"
      log_family.comparator_type    = "UTF8Type"
      log_family.subcomparator_type = "TimeUUIDType"
      log_family
    end
  end
end
