local socket = require "socket"
local udp = socket.udp()

udp:settimeout(0)
udp:setsockname('*', 12345)

local data, ip, port
local running = true

function split(inputstr)
    sep = "~"
    local t={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end

print "Beginning server loop."
while running do
    data, ip, port = udp:receivefrom()

    if data then
        data = split(data)
        print("Update Position of " .. data[2] .. " to " .. data[3] .. " x and " .. data[4] .. " y")
    end
end