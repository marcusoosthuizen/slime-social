socket = require "socket"

local udp = socket.udp()
local iplist = {}

udp:settimeout(0)
udp:setsockname('*', 12345)

function process(message)
    for i = 1, #iplist, 1
    do
        daStuff = iplist[i]
        udp:sendto(message, daStuff[1], daStuff[2])
    end
    --udp:sendto(message, tostring(ip), 12345)
    
end

while true do
    message = nil
    message, ip, port = udp:receivefrom()
    
    

    if message ~= "nil     timeout" and message ~= nil then
        newip = true
        dStuff = 0
        for i = 1, #iplist, 1
        do
            dStuff = iplist[i]
            if dStuff[1] == ip and dStuff[2] == port then
                newip = false
            end
        end
        if newip then
            table.insert(iplist, {ip, port})
        end
        
        print(message)
        print(#iplist)
        process(message, port)

    end
    
    
end