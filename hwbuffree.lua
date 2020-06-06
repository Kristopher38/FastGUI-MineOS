local gpu = require("component").gpu
print(gpu.freeMemory())
gpu.freeAllBuffers()