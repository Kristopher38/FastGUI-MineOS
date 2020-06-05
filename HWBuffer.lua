local gpu = require("component").gpu

-- Priority queue implemented using binary min heap
local HWBuffer = {}
HWBuffer.__index = HWBuffer
setmetatable(HWBuffer, {__call = function(cls, width, height)
    local self = {}
    self.width = width
    self.height = height
    self.bufferId = gpu.allocateBuffer(width, height)

    setmetatable(self, cls)
    return self
end })

local oldBufferIds = {}
local oldFgColors = {}
local oldBgColors = {}

function HWBuffer:startDraw()
    table.insert(oldBufferIds, (gpu.getActiveBuffer()))
    table.insert(oldFgColors, (gpu.getForeground()))
    table.insert(oldBgColors, (gpu.getBackground()))
    gpu.setActiveBuffer(self.bufferId)
end

function HWBuffer:endDraw()
    gpu.setActiveBuffer(table.remove(oldBufferIds))
    gpu.setForeground(table.remove(oldFgColors))
    gpu.setBackground(table.remove(oldBgColors))
end

function HWBuffer:drawRectangle(x, y, width, height, background, foreground, symbol, transparency)
    self:startDraw()
    gpu.setBackground(background)
    gpu.setForeground(foreground)
    gpu.fill(x, y, width, height, symbol)
    self:endDraw()
end

function HWBuffer:drawText(x, y, textColor, data, transparency, vertical)
    self:startDraw()
    gpu.setBackground(0x000000)
    gpu.setForeground(textColor)
    gpu.set(x, y, data, vertical)
    self:endDraw()
end

function HWBuffer:drawFrame(x, y, width, height, color)
    self:startDraw()
    local stringUp = "┌" .. string.rep("─", width - 2) .. "┐"
    local stringDown = "└" .. string.rep("─", width - 2) .. "┘" 
    local stringVertical = string.rep("│", height - 2)
	
    self:drawText(x, y, color, stringUp)
    self:drawText(x, y + height - 1, color, stringDown)
    self:drawText(x, y + 1, color, stringVertical, nil, true)
    self:drawText(x + width - 1, y + 1, color, stringVertical, nil, true)
    
    self:endDraw()
end

function HWBuffer:draw(col, row, width, height, fromCol, fromRow, destination)
    gpu.bitblt(destination, col, row, width, height, self.bufferId, fromCol, fromRow)
end

function HWBuffer:destroy()
    gpu.freeBuffer(self.bufferId)
end

return HWBuffer