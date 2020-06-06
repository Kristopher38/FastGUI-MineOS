package.loaded.HWBuffer = nil
package.loaded.GUI = nil
local HWBuffer = require("HWBuffer")
computer = require("computer")
unicode = require("unicode")
local gpu = require("component").gpu
local GUI = require("GUI")
local screen = require("Screen")
screen.setGPUProxy(gpu)

local workspace = GUI.workspace(1, 1, 160, 80)
local panel = workspace:addChild(GUI.panel(40, 15, 60, 20, 0xcc0000))

local buttonEnd = workspace:addChild(GUI.button(150, 40, 10, 10, 0xFF0000, 0x0, 0x0, 0x0, "ESC"))
buttonEnd.onTouch = function()
    workspace:stop()
end

local button = workspace:addChild(GUI.button(10, 10, 30, 5, 0xFFFFFF, 0x0, 0x000000, 0x0, "Dupsko"))

button.onTouch = function()
    panel.width = panel.width + 1
end

workspace:draw()
workspace:start()