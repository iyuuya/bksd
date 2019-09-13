# frozen_string_literal: true

require 'msgpack/rpc'

class MathService
  def add(x, y)
    puts :add, x, y
    x + y
  end

  def sub(x, y)
    puts :sub, x, y
    x - y
  end
end
serv = MessagePack::RPC::Server.new
service = MathService.new
serv.listen('0.0.0.0', ENV.fetch('PORT', 21000).to_i, service)
serv.run
