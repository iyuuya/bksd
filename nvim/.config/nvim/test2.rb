require 'msgpack/rpc'

cli = MessagePack::RPC::Client.new('localhost', 12345)
p cli.call(:run, :math, :add, 1, 2)
