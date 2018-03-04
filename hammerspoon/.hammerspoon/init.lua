-- vim: fdm=marker fdl=0

local hyper = {'ctrl', 'alt', 'cmd'}

-------------------------------------------------------------------------------
-- Functions: "{{{

function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == '.lua' then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

-- "}}}
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Watchers: "{{{

configWacther = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()
hs.alert.show('Config loaded')

-- "}}}
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Binds: "{{{

hs.hotkey.bind(hyper, 'R', function()
  hs.reload()
end)

hs.hotkey.bind(hyper, 'H', function()
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local screen = win:screen()
    cell = hs.grid.get(win, screen)
  end
end)

--[[
hs.hotkey.bind(hyper, 'H', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x - 32
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, 'L', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x + 32
  win:setFrame(f)
end)
]]

--- Alert
-- hs.hotkey.bind(hyper, 'W', function() hs.alert.show('Hello World') end)
--- Notification
-- hs.notify.new(hyper):send()

--- "}}}
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Plugins: "{{{

hs.loadSpoon('MiroWindowsManager')

hs.window.animationDuration = 0.1
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, 'k'},
  right = {hyper, 'l'},
  down = {hyper, 'j'},
  left = {hyper, 'h'},
  fullscreen = {hyper, 'f'}
})

-- "}}}
-------------------------------------------------------------------------------
