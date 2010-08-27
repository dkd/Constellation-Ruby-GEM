require "cassandra/0.7"

module Constellation
  module DataStores

    class Cassandra < ::Constellation::DataStore
      def establish_connection
        @server = Cassandra.new(@namespace, @host)
        @server.login!(@username, @password) if @username && @password
      end
    end

  end
end