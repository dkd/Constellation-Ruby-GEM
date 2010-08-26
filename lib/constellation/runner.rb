$:.unshift File.join(File.dirname(__FILE__),'vendor','thor')
require 'thor'
require 'thor/actions'
require 'rubygems/config_file'

module Constellation

  class Runner < Thor
    include Thor::Actions
  end

end