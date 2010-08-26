# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{constellation}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stefan Sprenger"]
  s.date = %q{2010-08-26}
  s.default_executable = %q{constellation}
  s.description = %q{TODO: longer description of your gem}
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
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "bin/constellation",
     "lib/constellation.rb",
     "lib/constellation/config.rb",
     "lib/constellation/data_store.rb",
     "lib/constellation/data_stores.rb",
     "lib/constellation/data_stores/cassandra.rb",
     "lib/constellation/reader.rb",
     "lib/constellation/runner.rb",
     "lib/constellation/version.rb",
     "spec/constellation/config_spec.rb",
     "spec/constellation/data_store_spec.rb",
     "spec/constellation/data_stores/cassandra_spec.rb",
     "spec/constellation/reader_spec.rb",
     "spec/constellation/runner_spec.rb",
     "spec/constellation/version_spec.rb",
     "spec/constellation_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/dkd/constellation}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{TODO: one-line summary of your gem}
  s.test_files = [
    "spec/constellation/config_spec.rb",
     "spec/constellation/data_store_spec.rb",
     "spec/constellation/data_stores/cassandra_spec.rb",
     "spec/constellation/reader_spec.rb",
     "spec/constellation/runner_spec.rb",
     "spec/constellation/version_spec.rb",
     "spec/constellation_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

