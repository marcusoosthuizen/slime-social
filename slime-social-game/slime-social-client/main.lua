local init = require "engine/init"
local update = require "engine/update"
local render = require "engine/render"
local input = require "engine/input"
local button = require "entities/button"
socket = require "socket"
cht = require "engine/chat"

version = "0.3.2"


pl = require "entities/player"

daName = ""
mode = 0
typedMessage = ""

pl.init(daName, 50, 50)

fr = require "entities/friend"
local friends = {}

local cm = require "entities/camera"
cm.init(0, 0)

local test = love.graphics.newImage("sprites/world.png")

local updaterate = 0.1
local counter = 0
local rmlist = {}

bList = {}
table.insert(bList, button:new(nil))
--bList[#bList]:init("Join", )

function splitt(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end


function process(msg, dt)
    if msg[2] ~= pl.name and msg[1] == "M" then
        local exists = false
        for i = 1, #friends, 1
        do
            --friend = friends[i]
            if friends[i].name == msg[2] then
                exists = true
                friends[i]:send(tonumber(msg[3]), tonumber(msg[4]), tonumber(msg[5]))
            end
        end
        if exists == false then
            table.insert(friends, fr:new(nil))
            friends[#friends]:init(msg[2], tonumber(msg[3]), tonumber(msg[4]), tonumber(msg[5]))
        end
    elseif msg[2] ~= pl.name and msg[1] == "C" then
        local tempmsg = ""
        for i = 3, #msg, 1
        do
            tempmsg = tempmsg .. tostring(msg[i]) .. " "
        end
        
        cht.send(tempmsg, msg[2])
    end
    
    
end

function love.load()

    udp = socket.udp()
    udp:settimeout(0)
    udp:setpeername("45.76.122.24", 12345)

    --udp:send("hi uwu")

    init.start()
end

function love.update(dt)

    if mode == 0 then
        mouseX = love.mouse.getX()
        mouseY = love.mouse.getY()
        if mouseX > 450 - render.font4:getWidth("Join") / 2 and mouseX < 450 + render.font4:getWidth("Join") / 2 and mouseY > 250 and mouseY < 250 + render.font4:getHeight() and love.mouse.isDown(1) then
            mode = 2
        end
    else
    
        if mode == 1 then 
            typedMessage = ""
            keys = input.get()
            pl.update(keys, dt) 
        else
            local daInput = input.type()
            if daInput == "backspace" then
                typedMessage = typedMessage:sub(1, string.len(typedMessage) - 1)
            elseif typedMessage:len() < 21 then
                typedMessage = typedMessage .. daInput
            end
            pl.update({}, dt) 

        end
        
        cm.update(pl.x, pl.y, 16, 16, pl.rotation, 4, "smooth", dt)

        if daName ~= "" then
            counter = counter + dt
            if counter > updaterate then
                message = "M " .. tostring(pl.name) .. " " .. tostring(pl.x) .. " " .. tostring(pl.y) .. " " .. tostring(pl.rotation)
                udp:send(message)
                counter = 0
            end

            repeat
                message = udp:receive()
                if message ~= "nil     connection refused" and message ~= nil then
                    message = splitt(message, " ")
                    process(message, dt)
                end

            until not message

            rmlist = {}
            for i = 1, #friends, 1
            do
                friends[i]:update(dt)
                if friends[i].timeout > 5 then
                    table.insert(rmlist, i)
                end
            end
            for i = 1, #rmlist, 1
            do
                cht.send(friends[rmlist[i]].name .. " has left the room")
                table.remove(friends, rmlist[i])
            end

            cht.update(dt)
        end
    
    end
    
end

function love.draw()

    if mode == 0 then
        render.menu()
    else
        queue = {}
        table.insert(queue, {0, 0, test})

        for i = 1, #friends, 1
        do
            table.insert(queue, friends[i]:getRender())
        end

        table.insert(queue, pl.getRender())
        

        render.draw(queue, {cm.x, cm.y})
        --render.chat(cht.get())
    end
end

