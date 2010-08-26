require 'thor'
require 'thor/actions'
require 'rubygems/config_file'

module Constellation

  class Runner < Thor
    include Thor::Actions
  end

end