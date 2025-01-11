friend = {counter = 0, index = 0, quads = {}}
local font = love.graphics.newFont("fonts/pressstart.ttf", 16)

function friend:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function friend:init(name, x, y, rotation)
    self.name = name
    self.x = x
    self.y = y
    self.dx = x
    self.dy = y
    self.counter = 0
    self.rotation = rotation
    love.graphics.setDefaultFilter("nearest", "nearest")
    self.sprite = love.graphics.newImage("sprites/player.png")

    self.timeout = 0
    cht.send(self.name .. " has joined the room")

    for q = 0, 2, 1
    do self.quads[q] = love.graphics.newQuad(20 * q, 0, 20, 20, self.sprite:getDimensions()) end
end

function friend:getRender()
    local chatting = false
    local chatLength = 0
    for i = #chat.list, 1, -1
    do
        if chat.list[i][3] == self.name then
            chatting = true
            chatLength = math.floor(font:getWidth(chat.list[i][1]) / 6)
            return {self.x, self.y, self.rotation, self.sprite, self.quads[self.index], self.name, chatting, chat.list[i][1], chatLength - 1}
        end
    end
    
    return {self.x, self.y, self.rotation, self.sprite, self.quads[self.index], self.name}
end

function friend:stepAnimation(dt)
    self.counter = self.counter + dt

    if self.counter > 0.3 then
        self.counter = 0
        self.index = self.index + 1
        if self.index == 2 then
            self.index = 0
        end
    end
end

function friend:send(x, y, rotation)
    self.dx = x
    self.dy = y

    if self.rotation == 1 and rotation == -1 then
        self.x = self.x + 16
    elseif self.rotation == -1 and rotation == 1 then
        self.x = self.x - 16
    end

    self.rotation = rotation
    self.timeout = 0
end

function friend:update(dt)
    moving = false
    if self.x > self.dx then 
        diff = self.x - self.dx
        self.x = self.x - diff * 10 * dt
        moving = true
        if diff < 1 then
            self.x = self.dx
            moving = false
        end
        
    elseif self.x < self.dx then 
        diff = self.dx - self.x
        self.x = self.x + diff * 10 * dt 
        moving = true
        if diff < 1 then
            self.x = self.dx
            moving = false
        end
    end

    if self.y > self.dy then 
        diff = self.y - self.dy
        self.y = self.y - diff * 10 * dt
        moving = true
        if diff < 1 then
            self.y = self.dy
            moving = false
        end
        
    elseif self.y < self.dy then 
        diff = self.dy - self.y
        self.y = self.y + diff * 10 * dt 
        moving = true
        if diff < 1 then
            self.y = self.dy
            moving = false
        end
    end


    if moving then
        self:stepAnimation(dt)
    else
        self.index = 0
    end

    self.timeout = self.timeout + dt
    
    
end

return friend