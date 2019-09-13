# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('~/working/msgpack-rpc-gateway/lib')
require 'msgpack/rpc'
require 'msgpack/rpc/gateway'

MessagePack::RPC::Gateway.start('0.0.0.0', 20000) do |gateway|
  gateway.register('math', 'localhost', 21000)
  gateway.register('math', 'localhost', 21001)
end
