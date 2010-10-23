# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simple_uuid}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0.8") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan King, Evan Weaver"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDNjCCAh6gAwIBAgIBADANBgkqhkiG9w0BAQUFADBBMQ0wCwYDVQQDDARyeWFu\nMRswGQYKCZImiZPyLGQBGRYLdGhlcnlhbmtpbmcxEzARBgoJkiaJk/IsZAEZFgNj\nb20wHhcNMTAwMTA4MTc1MDM0WhcNMTEwMTA4MTc1MDM0WjBBMQ0wCwYDVQQDDARy\neWFuMRswGQYKCZImiZPyLGQBGRYLdGhlcnlhbmtpbmcxEzARBgoJkiaJk/IsZAEZ\nFgNjb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDLPp+0PtRT3qCI\n02sMsADSn7Uf1GpyXUtk4Fb94LqUO6Scl91YDmbFMpjzrQwQvBYMIVreWcwSish6\nnip6WEk9lqXcOeDmex/qY2/FVXG8ffqjFHiNiN9vpWrWj5VMICequ+ftzWLKsPIS\nDGJ4o+Z6wEYRuirgaRPCYAUDPglsaqctJ56wPuycryMe5+ApSkOS9iLWMprQKEAq\nj2R2OBV0dSARdbtzuKwrP7sLDo7uPa0egFBUlcZ+nujGr4LvmpryB8scNRNmZK1w\n1rEI7O06CbULj08qYxEhnKmFE7LbBoN/HrmvZLVQK5mWuiZQhtmJuhBfStJsaDux\n5tBEkYZVAgMBAAGjOTA3MAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdDgQW\nBBSnLarDEo5eBE2arSMrBdOOhtrnPTANBgkqhkiG9w0BAQUFAAOCAQEANER07s4K\nPvc1DSduliRDMUax/VSfLzDTtTAQwuSAPDrWAYXKugcJtOZOXjDbGL7c5zoWmy9u\nFn5vEVdm/93J+84D/IMaaof3BwX/NNEYH01CeZEIGMfc5AFFha7dabzP/uiPpb/c\nGSvomC9IzyN37+eWwOS16cC+5XnBT6KRCaXYg2Fh6WpTgde67OVgXr4Q58HXlaZ+\n/2BB3wq9lZ4JskvlpYpYnlPAUyiyc6R2Mjts1pURz5nkW4SuS7Kd1KCOOyr1McDH\nVP12sTSjJclmI17BjDGQpAF0n9v5ExhJxWpeOjeBUPQsOin3ypEM1KkckLmOKvH6\nzyKMYVRO0z/58g==\n-----END CERTIFICATE-----\n"]
  s.date = %q{2010-03-23}
  s.description = %q{Simple, scalable UUID generation.}
  s.email = %q{ryan@twitter.com}
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.rdoc", "lib/simple_uuid.rb"]
  s.files = ["CHANGELOG", "LICENSE", "Manifest", "README.rdoc", "Rakefile", "lib/simple_uuid.rb", "simple_uuid.gemspec", "test/test_uuid.rb"]
  s.homepage = %q{http://blog.evanweaver.com/files/doc/fauna/simple_uuid/}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Simple_uuid", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fauna}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Simple, scalable UUID generation.}
  s.test_files = ["test/test_uuid.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
