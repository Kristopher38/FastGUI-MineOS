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
local object = workspace:addChild(GUI.panel(40, 15, 60, 20, 0xcc0000))

workspace:draw()
workspace:start()