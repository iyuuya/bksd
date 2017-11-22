if type -q nvim
  function v --wraps 'nvim'
    nvim $argv
  end
else if type -q vim
  function v --wraps 'vim'
    vim $argv
  end
else
  function v --wraps 'vi'
    vi $argv
  end
end
