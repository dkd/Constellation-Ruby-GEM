require "thor"

module Constellation
  #
  # UserInterface handles user in- and output and offers some possibilities as colorizing
  # shell output.
  #
  class UserInterface
    @@shell = Thor::Shell::Color.new
    @@muted = false

    class << self
      def mute!
        @@muted = true
      end

      def unmute!
        @@muted = false
      end

      def inform(message, options={})
        put(message, nil, options)
      end

      def confirm(message, options={})
        put(message, :green, options)
      end

      def warn(message, options={})
        put(message, :yellow, options)
      end

      def error(message, options={})
        put(message, :red, options)
      end

      def put(message, color, options={})
        return if @@muted
        @@shell.say("") if options[:prepend_newline]
        @@shell.say(message, color)
      end
    end
  end
end