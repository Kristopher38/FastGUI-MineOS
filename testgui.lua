package.loaded.HWBuffer = nil
package.loaded.GUI = nil
local HWBuffer = require("HWBuffer")
computer = require("computer")
unicode = require("unicode")
local gpu = require("component").gpu
local GUI = require("GUI")
local screen = require("Screen")
local event = require("event")
screen.setGPUProxy(gpu)
event.sleep = os.sleep

local workspace = GUI.workspace(1, 1, 160, 80)
local panel = workspace:addChild(GUI.panel(40, 15, 60, 20, 0xcc0000))
local text = workspace:addChild(GUI.text(1, 49, 0xFFFFFF, "Hello world!"))
local label = workspace:addChild(GUI.label(1, 1, workspace.width, workspace.height, 0xFFFFFF, "Dupsko"))

local buttonEnd = workspace:addChild(GUI.button(150, 45, 10, 5, 0xFF0000, 0x0, 0xCC0000, 0xFF0000, "ESC"))
buttonEnd.onTouch = function()
    workspace:stop()
end

local buttonResize = workspace:addChild(GUI.button(10, 1, 20, 3, 0xFF0000, 0x0, 0xCC0000, 0xFF0000, "Resize"))
buttonResize.onTouch = function()
    panel.width = panel.width + 1
end

local buttonChangeColor = workspace:addChild(GUI.button(10, 4, 20, 3, 0xFF0000, 0x0, 0xCC0000, 0xFF0000, "Change color"))
buttonChangeColor.onTouch = function()
    panel.colors = {background = (panel.colors.background + 0xdeadbeef) % 0xffffff, transparency = 0.5}
    text.color = (text.color + 0xdeadbeef) % 0xffffff
    label.colors.text = (label.colors.text + 0xdeadbeef) % 0xffffff
end

local buttonChangeText = workspace:addChild(GUI.button(10, 7, 20, 3, 0xFF0000, 0x0, 0xCC0000, 0xFF0000, "Change text"))
buttonChangeText.onTouch = function()
    local str = string.rep(unicode.char(math.random(32, 126)), math.random(1, 30))
    text.text = str
    label.text = str
end



workspace:draw()
workspace:start()

-- clear the screen, tell if all buffers were freed and free the remaining ones
gpu.setBackground(0x0)
gpu.setForeground(0xFFFFFF)
gpu.fill(1, 1, 160, 50, " ")
print(gpu.freeMemory())
gpu.freeAllBuffers()