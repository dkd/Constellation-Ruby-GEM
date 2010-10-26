# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{thrift}
  s.version = "0.2.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Ballard, Kevin Clark, Mark Slee, Evan Weaver"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDLjCCAhagAwIBAgIBADANBgkqhkiG9w0BAQUFADA9MQ0wCwYDVQQDDARldmFu\nMRgwFgYKCZImiZPyLGQBGRYIY2xvdWRidXIxEjAQBgoJkiaJk/IsZAEZFgJzdDAe\nFw0wNzA5MTYxMDMzMDBaFw0wODA5MTUxMDMzMDBaMD0xDTALBgNVBAMMBGV2YW4x\nGDAWBgoJkiaJk/IsZAEZFghjbG91ZGJ1cjESMBAGCgmSJomT8ixkARkWAnN0MIIB\nIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5C0Io89nyApnr+PvbNFge9Vs\nyRWAlGBUEMahpXp28VrrfXZT0rAW7JBo4PlCE3jl4nE4dzE6gAdItSycjTosrw7A\nIr5+xoyl4Vb35adv56TIQQXvNz+BzlqnkAY5JN0CSBRTQb6mxS3hFyD/h4qgDosj\nR2RFVzHqSxCS8xq4Ny8uzOwOi+Xyu4w67fI5JvnPvMxqrlR1eaIQHmxnf76RzC46\nQO5QhufjAYGGXd960XzbQsQyTDUYJzrvT7AdOfiyZzKQykKt8dEpDn+QPjFTnGnT\nQmgJBX5WJN0lHF2l1sbv3gh4Kn1tZu+kTUqeXY6ShAoDTyvZRiFqQdwh8w2lTQID\nAQABozkwNzAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHQ4EFgQU+WqJz3xQ\nXSea1hRvvHWcIMgeeC4wDQYJKoZIhvcNAQEFBQADggEBAGLZ75jfOEW8Nsl26CTt\nJFrWxQTcQT/UljeefVE3xYr7lc9oQjbqO3FOyued3qW7TaNEtZfSHoYeUSMYbpw1\nXAwocIPuSRFDGM4B+hgQGVDx8PMGiJKom4qLXjO40UZsR7QyN/u869Vj45LURm6h\nMBcPeqCASI+WNprj9+uZa2kmHiitrFqqfMBNlm5IFbn9XeYSta9AHVvs5QQqV2m5\nhIPfLqCyxsn/YgOGvo6iwyQTWyTswamaAC3HRWZxIS1sfn/Ssqa7E7oQMkv5FAXr\nx5rKePfXINf8XTJczkl9OBEYdE9aNdJsJpXD0asLgGVwBICS5Bjohp6mizJcDC1+\nyZ0=\n-----END CERTIFICATE-----\n"]
  s.date = %q{2010-05-24}
  s.description = %q{Ruby libraries for Thrift (a language-agnostic RPC system)}
  s.email = %q{}
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["CHANGELOG", "README", "ext/binary_protocol_accelerated.c", "ext/binary_protocol_accelerated.h", "ext/compact_protocol.c", "ext/compact_protocol.h", "ext/constants.h", "ext/extconf.rb", "ext/macros.h", "ext/memory_buffer.c", "ext/memory_buffer.h", "ext/protocol.c", "ext/protocol.h", "ext/struct.c", "ext/struct.h", "ext/thrift_native.c", "lib/thrift.rb", "lib/thrift/client.rb", "lib/thrift/core_ext.rb", "lib/thrift/core_ext/fixnum.rb", "lib/thrift/exceptions.rb", "lib/thrift/processor.rb", "lib/thrift/protocol/base_protocol.rb", "lib/thrift/protocol/binary_protocol.rb", "lib/thrift/protocol/binary_protocol_accelerated.rb", "lib/thrift/protocol/binaryprotocol.rb", "lib/thrift/protocol/binaryprotocolaccelerated.rb", "lib/thrift/protocol/compact_protocol.rb", "lib/thrift/protocol/tbinaryprotocol.rb", "lib/thrift/protocol/tprotocol.rb", "lib/thrift/serializer/deserializer.rb", "lib/thrift/serializer/serializer.rb", "lib/thrift/server/base_server.rb", "lib/thrift/server/httpserver.rb", "lib/thrift/server/mongrel_http_server.rb", "lib/thrift/server/nonblocking_server.rb", "lib/thrift/server/nonblockingserver.rb", "lib/thrift/server/simple_server.rb", "lib/thrift/server/thread_pool_server.rb", "lib/thrift/server/threaded_server.rb", "lib/thrift/server/thttpserver.rb", "lib/thrift/server/tserver.rb", "lib/thrift/struct.rb", "lib/thrift/thrift_native.rb", "lib/thrift/transport/base_server_transport.rb", "lib/thrift/transport/base_transport.rb", "lib/thrift/transport/buffered_transport.rb", "lib/thrift/transport/framed_transport.rb", "lib/thrift/transport/http_client_transport.rb", "lib/thrift/transport/io_stream_transport.rb", "lib/thrift/transport/memory_buffer_transport.rb", "lib/thrift/transport/server_socket.rb", "lib/thrift/transport/socket.rb", "lib/thrift/transport/unix_server_socket.rb", "lib/thrift/transport/unix_socket.rb", "lib/thrift/types.rb"]
  s.files = ["CHANGELOG", "Makefile.am", "Manifest", "README", "Rakefile", "benchmark/Benchmark.thrift", "benchmark/benchmark.rb", "benchmark/client.rb", "benchmark/gen-rb/BenchmarkService.rb", "benchmark/gen-rb/Benchmark_constants.rb", "benchmark/gen-rb/Benchmark_types.rb", "benchmark/server.rb", "benchmark/thin_server.rb", "ext/binary_protocol_accelerated.c", "ext/binary_protocol_accelerated.h", "ext/compact_protocol.c", "ext/compact_protocol.h", "ext/constants.h", "ext/extconf.rb", "ext/macros.h", "ext/memory_buffer.c", "ext/memory_buffer.h", "ext/protocol.c", "ext/protocol.h", "ext/struct.c", "ext/struct.h", "ext/thrift_native.c", "lib/thrift.rb", "lib/thrift/client.rb", "lib/thrift/core_ext.rb", "lib/thrift/core_ext/fixnum.rb", "lib/thrift/exceptions.rb", "lib/thrift/processor.rb", "lib/thrift/protocol/base_protocol.rb", "lib/thrift/protocol/binary_protocol.rb", "lib/thrift/protocol/binary_protocol_accelerated.rb", "lib/thrift/protocol/binaryprotocol.rb", "lib/thrift/protocol/binaryprotocolaccelerated.rb", "lib/thrift/protocol/compact_protocol.rb", "lib/thrift/protocol/tbinaryprotocol.rb", "lib/thrift/protocol/tprotocol.rb", "lib/thrift/serializer/deserializer.rb", "lib/thrift/serializer/serializer.rb", "lib/thrift/server/base_server.rb", "lib/thrift/server/httpserver.rb", "lib/thrift/server/mongrel_http_server.rb", "lib/thrift/server/nonblocking_server.rb", "lib/thrift/server/nonblockingserver.rb", "lib/thrift/server/simple_server.rb", "lib/thrift/server/thread_pool_server.rb", "lib/thrift/server/threaded_server.rb", "lib/thrift/server/thttpserver.rb", "lib/thrift/server/tserver.rb", "lib/thrift/struct.rb", "lib/thrift/thrift_native.rb", "lib/thrift/transport/base_server_transport.rb", "lib/thrift/transport/base_transport.rb", "lib/thrift/transport/buffered_transport.rb", "lib/thrift/transport/framed_transport.rb", "lib/thrift/transport/http_client_transport.rb", "lib/thrift/transport/io_stream_transport.rb", "lib/thrift/transport/memory_buffer_transport.rb", "lib/thrift/transport/server_socket.rb", "lib/thrift/transport/socket.rb", "lib/thrift/transport/unix_server_socket.rb", "lib/thrift/transport/unix_socket.rb", "lib/thrift/types.rb", "script/proto_benchmark.rb", "script/read_struct.rb", "script/write_struct.rb", "setup.rb", "spec/ThriftSpec.thrift", "spec/base_protocol_spec.rb", "spec/base_transport_spec.rb", "spec/binary_protocol_accelerated_spec.rb", "spec/binary_protocol_spec.rb", "spec/binary_protocol_spec_shared.rb", "spec/client_spec.rb", "spec/compact_protocol_spec.rb", "spec/exception_spec.rb", "spec/gen-rb/NonblockingService.rb", "spec/gen-rb/ThriftSpec_constants.rb", "spec/gen-rb/ThriftSpec_types.rb", "spec/http_client_spec.rb", "spec/mongrel_http_server_spec.rb", "spec/nonblocking_server_spec.rb", "spec/processor_spec.rb", "spec/serializer_spec.rb", "spec/server_socket_spec.rb", "spec/server_spec.rb", "spec/socket_spec.rb", "spec/socket_spec_shared.rb", "spec/spec_helper.rb", "spec/struct_spec.rb", "spec/types_spec.rb", "spec/unix_socket_spec.rb", "thrift.gemspec"]
  s.homepage = %q{http://blog.evanweaver.com/files/doc/fauna/thrift/}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Thrift", "--main", "README"]
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = %q{fauna}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby libraries for Thrift (a language-agnostic RPC system)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end