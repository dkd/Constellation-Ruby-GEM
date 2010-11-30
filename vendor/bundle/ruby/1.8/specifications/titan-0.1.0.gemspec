# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{titan}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stefan Sprenger"]
  s.date = %q{2010-11-26}
  s.description = %q{Helps you creating and managing daemon threads with Ruby.}
  s.email = %q{info@stefan-sprenger.com}
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["lib/titan/thread.rb", "lib/titan/version.rb", "lib/titan.rb", "LICENSE", "README.md", "CHANGELOG.md"]
  s.homepage = %q{http://github.com/flippingbits/titan}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Helps you creating and managing daemon threads with Ruby.}

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
