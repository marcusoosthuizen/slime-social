network = {}

function network.init()
    network.socket = require "socket"
    network.udp = network.socket.udp()
    network.udp:settimeout(0)
    network.udp:setpeername('45.76.122.24', 12345)
end

function network.updatePos()
    network.udp:send("P~" .. player.name .. "~" .. player.x .. "~" .. player.y)
    print("P~" .. player.name .. "~" .. player.x .. "~" .. player.y)
end

function network.updateMsg(message)
    network.udp:send("M~" .. player.name .. "~" .. message)
end

return network