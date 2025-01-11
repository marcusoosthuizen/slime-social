player = {}

local counter = 0
local blinkCounter = 0
local index = 0
local quads = {}
local font = love.graphics.newFont("fonts/pressstart.ttf", 16)

function player.init(name, x, y)
    player.name = name
    player.x = x
    player.y = y
    player.rotation = 1
    love.graphics.setDefaultFilter("nearest", "nearest")
    player.sprite = love.graphics.newImage("sprites/player.png")

    for q = 0, 2, 1
    do quads[q] = love.graphics.newQuad(20 * q, 0, 20, 20, player.sprite:getDimensions()) end
end

function player.getRender()
    local chatting = false
    local chatLength = 0
    
    if mode == 2 then
        chatting = true
        chatLength = font:getWidth(typedMessage .. "_") / 6
        if blinkCounter > 1 then
            return {player.x, player.y, player.rotation, player.sprite, quads[index], player.name, "pl", chatting, typedMessage .. " ", chatLength, 0.5}
        else
            return {player.x, player.y, player.rotation, player.sprite, quads[index], player.name, "pl", chatting, typedMessage .. "_", chatLength, 0.5}
        end
     end
    
    for i = #chat.list, 1, -1
    do
        if chat.list[i][3] == player.name then
            chatting = true
            chatLength = math.floor(font:getWidth(chat.list[i][1]) / 6)
            return {player.x, player.y, player.rotation, player.sprite, quads[index], player.name, "pl", chatting, chat.list[i][1], chatLength, 1}
        end
    end
    

    return {player.x, player.y, player.rotation, player.sprite, quads[index], player.name, "pl", chatting}
end

function player.stepAnimation(dt)
    counter = counter + dt

    if counter > 0.3 then
        counter = 0
        index = index + 1
        if index == 2 then
            index = 0
        end
    end
end

function player.update(keys, dt)

    blinkCounter = blinkCounter + dt * 2
    if blinkCounter >= 2 then
        blinkCounter = 0
    end

    moving = false
    for i = 0, #keys, 1
    do
        if keys[i] == "up" then
            player.y = player.y + -50 * dt
            moving = true
        end
        if keys[i] == "down" then
            player.y = player.y + 50 * dt
            moving = true
        end
        if keys[i] == "left" then
            if player.rotation == -1 then
                player.x = player.x - 16
            end
            player.rotation = 1
            player.x = player.x + -50 * dt
            moving = true
        end
        if keys[i] == "right" then
            if player.rotation == 1 then
                player.x = player.x + 16
            end
            player.rotation = -1
            player.x = player.x + 50 * dt
            moving = true
        end
        if keys[i] == "b" then
            moving = true
        end
    end
    if moving then
        player.stepAnimation(dt)
    else
        index = 0
    end
    
end

return player