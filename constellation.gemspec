$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "constellation/version"

Gem::Specification.new do |s|
  s.name                      = %q{constellation}
  s.version                   = Constellation::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors                   = ["Stefan Sprenger"]
  s.date                      = Time.now.strftime("%Y-%m-%d")
  s.default_executable        = %q{constellation}
  s.description               = %q{Observes log files of all of your servers.}
  s.email                     = %q{stefan.sprenger@dkd.de}
  s.executables               = ["constellation"]
  s.extra_rdoc_files          = ["LICENSE", "README.md"]
  s.files                     = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md CHANGELOG.md Gemfile Gemfile.lock)
  s.homepage                  = %q{http://github.com/dkd/constellation}
  s.rdoc_options              = ["--charset=UTF-8"]
  s.require_paths             = ["lib"]
  s.rubygems_version          = %q{1.3.7}
  s.summary                   = %q{Observes log files of all of your servers.}

  s.add_dependency("activemodel")
  #s.add_dependency("cassandra")
  s.add_dependency("json")
  s.add_dependency("simple_uuid")
  s.add_dependency("thor")
  s.add_dependency("thrift_client")
  s.add_dependency("titan")

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
  end
end

