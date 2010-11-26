require 'rake'

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/constellation/*_spec.rb', 'spec/constellation_spec.rb']
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "constellation #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "constellation/version"
task :build do
  system "gem build constellation.gemspec"
end

task :install => :build do
  system "sudo gem install constellation-#{Constellation::VERSION}"
end

require 'metric_fu'
MetricFu::Configuration.run do |config|
  #define which metrics you want to use
  config.metrics  = [:churn, :saikuro, :flog, :flay, :reek, :roodi, :rcov]
  config.graphs   = []
  config.flay     = { :dirs_to_flay => ['lib']  }
  config.flog     = { :dirs_to_flog => ['lib']  }
  config.reek     = { :dirs_to_reek => ['lib']  }
  config.roodi    = { :dirs_to_roodi => ['lib'] }
  config.saikuro  = { :output_directory => 'scratch_directory/saikuro',
                      :input_directory => ['lib'],
                      :cyclo => "",
                      :filter_cyclo => "0",
                      :warn_cyclo => "5",
                      :error_cyclo => "7",
                      :formater => "text"} #this needs to be set to "text"
  config.churn    = { :start_date => "1 year ago", :minimum_churn_count => 10}
  config.rcov     = { :test_files => ["spec/constellation/*_spec.rb", "spec/constellation_spec.rb"],
                      :rcov_opts => ["--sort coverage",
                                     "--no-html",
                                     "--text-coverage",
                                     "--no-color",
                                     "--profile",
                                     "--spec-only",
                                     "--exclude /gems/,/Library/,spec"]}
end
