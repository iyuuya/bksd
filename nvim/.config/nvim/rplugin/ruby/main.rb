require 'msgpack/rpc'

Neovim.plugin do |plug|
  plug.command(:SetLine, nargs: 1) do |nvim, str|
    nvim.current.line = str
  end

  plug.function(:AAList, nargs: 0, sync: true) do |nvim|
    MessagePack::RPC::Client.new('localhost', 12345).call(:list)
  end

  # plug.function(:Sum, nargs: 2, sync: true) do |_, x, y|
  #   cli = MessagePack::RPC::Client.new('localhost', 12345)
  #   cli.call(:run, :math, :add, x, y)
  # end

  # plug.function(:Sub, nargs: 2, sync: true) do |_, x, y|
  #   cli = MessagePack::RPC::Client.new('localhost', 12345)
  #   cli.call(:run, :math, :sub, x, y)
  # end

  plug.autocmd(:BufEnter, pattern: '*.rb') do |nvim|
    nvim.command("echo 'hello'")
  end
end
