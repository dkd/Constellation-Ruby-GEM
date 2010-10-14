# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{constellation}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stefan Sprenger"]
  s.date = %q{2010-10-14}
  s.default_executable = %q{constellation}
  s.description = %q{Observes log files of all of your servers.}
  s.email = %q{stefan.sprenger@dkd.de}
  s.executables = ["constellation"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "CHANGELOG.md",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "bin/constellation",
     "constellation.gemspec",
     "lib/constellation.rb",
     "lib/constellation/config.rb",
     "lib/constellation/data_store.rb",
     "lib/constellation/log_entry.rb",
     "lib/constellation/reader.rb",
     "lib/constellation/runner.rb",
     "lib/constellation/version.rb",
     "spec/constellation/config_spec.rb",
     "spec/constellation/data_store_spec.rb",
     "spec/constellation/log_entry_spec.rb",
     "spec/constellation/reader_spec.rb",
     "spec/constellation/runner_spec.rb",
     "spec/constellation/version_spec.rb",
     "spec/constellation_spec.rb",
     "spec/helpers/cassandra_helper.rb",
     "spec/helpers/file_helper.rb",
     "spec/helpers/singleton_helper.rb",
     "spec/performance/ConstellationFile",
     "spec/performance/logs",
     "spec/performance/reliability_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "vendor/cache/cassandra-0.10.0.gem",
     "vendor/cache/json-1.4.6.gem",
     "vendor/cache/macaddr-1.0.0.gem",
     "vendor/cache/rake-0.8.7.gem",
     "vendor/cache/rspec-1.3.0.gem",
     "vendor/cache/simple_uuid-0.1.1.gem",
     "vendor/cache/thor-0.14.2.gem",
     "vendor/cache/thrift-0.2.0.4.gem",
     "vendor/cache/thrift_client-0.5.0.gem",
     "vendor/cache/uuid-2.3.1.gem"
  ]
  s.homepage = %q{http://github.com/dkd/constellation}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Observes log files of all of your servers.}
  s.test_files = [
    "spec/constellation/config_spec.rb",
     "spec/constellation/data_store_spec.rb",
     "spec/constellation/log_entry_spec.rb",
     "spec/constellation/reader_spec.rb",
     "spec/constellation/runner_spec.rb",
     "spec/constellation/version_spec.rb",
     "spec/constellation_spec.rb",
     "spec/helpers/cassandra_helper.rb",
     "spec/helpers/file_helper.rb",
     "spec/helpers/singleton_helper.rb",
     "spec/performance/reliability_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

