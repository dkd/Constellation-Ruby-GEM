require "thor"

module Constellation

  class Runner < Thor
    include Thor::Actions

    @@config = Config.new

    class << self

      def run!
      end

    end
  end

end