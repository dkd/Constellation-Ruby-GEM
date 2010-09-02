module CassandraHelpers

  class << self

    def drop_keyspace(keyspace_name)
      server = Cassandra.new("system","127.0.0.1:9160")
      begin
        server.drop_keyspace(keyspace_name)
      rescue
      end
    end

  end

end