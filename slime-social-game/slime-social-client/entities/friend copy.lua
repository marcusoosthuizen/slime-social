friend = {}

local counter = 0
local index = 0
local quads = {}

function friend.init(name, x, y, rotation)
    friend.name = name
    friend.x = x
    friend.y = y
    friend.dx = x
    friend.dy = y
    friend.rotation = rotation
    love.graphics.setDefaultFilter("nearest", "nearest")
    friend.sprite = love.graphics.newImage("sprites/player.png")

    for q = 0, 3, 1
    do quads[q] = love.graphics.newQuad(16 * q, 0, 16, 16, friend.sprite:getDimensions()) end
end

function friend.getRender()
    return {friend.x, friend.y, friend.rotation, friend.sprite, quads[index], friend.name}
end

function friend.stepAnimation(dt)
    counter = counter + dt

    if counter > 0.3 then
        counter = 0
        index = index + 1
        if index == 2 then
            index = 0
        end
    end
end

function friend.send(x, y, rotation)
    friend.dx = x
    friend.dy = y

    if friend.rotation == 1 and rotation == -1 then
        friend.x = friend.x + 16
    elseif friend.rotation == -1 and rotation == 1 then
        friend.x = friend.x - 16
    end

    friend.rotation = rotation
end

function friend.update(dt)
    moving = false
    if friend.x > friend.dx then 
        diff = friend.x - friend.dx
        friend.x = friend.x - diff * 10 * dt
        moving = true
        if diff < 1 then
            friend.x = friend.dx
            moving = false
        end
        
    elseif friend.x < friend.dx then 
        diff = friend.dx - friend.x
        friend.x = friend.x + diff * 10 * dt 
        moving = true
        if diff < 1 then
            friend.x = friend.dx
            moving = false
        end
    end

    if friend.y > friend.dy then 
        diff = friend.y - friend.dy
        friend.y = friend.y - diff * 10 * dt
        moving = true
        if diff < 1 then
            friend.y = friend.dy
            moving = false
        end
        
    elseif friend.y < friend.dy then 
        diff = friend.dy - friend.y
        friend.y = friend.y + diff * 10 * dt 
        moving = true
        if diff < 1 then
            friend.y = friend.dy
            moving = false
        end
    end


    if moving then
        friend.stepAnimation(dt)
    else
        index = 0
    end

        
    
    
end

return friend