local HWBuffer = require("HWBuffer")

local buf = HWBuffer(40, 20)
buf:drawRectangle(1, 1, 39, 19, 0x333333, 0x000000, " ")
buf:drawFrame(1, 1, 39, 19, 0xdd0000)
buf:drawText(2, 2, 0xFFFFFF, "Lorem ipsum dolor sit amet")
buf:draw()

buf:destroy()