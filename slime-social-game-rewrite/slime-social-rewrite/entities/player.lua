entity = {}

function entity:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function entity:init(x, y)
    self.x = x
    self.y = y
    self.name = "bob"

    self.width = 20
    self.height = 20
    
    self.spritesheet = love.graphics.newImage("sprites/player.png")
    self.quads = {}
    for i = 1, self.spritesheet:getWidth() / self.width + 1, 1 do
        self.quads[i] = (love.graphics.newQuad(20 * (i - 1), 0, 20, 20, self.spritesheet:getDimensions()))
    end
    self.quad = self.quads[1]
    
    self.scale = 5
    self.rotation = 1
    self.moving = false
    self.animationStep = 0
end

function entity:update(dt)
    local keys = input.get()
    local xInc = 0
    local yInc = 0

    self.moving = false

    for i = 0, #keys, 1 do
        key = keys[i]
        if key == "up" then
            yInc = -63
        elseif key == "down" then
            yInc = 63
        elseif key == "left" then
            xInc = -63
        elseif key == "right" then
            xInc = 63
        end
    end
    
    if xInc ~= 0 and yInc ~= 0 then
        xInc = xInc * 0.7
        yInc = yInc * 0.7
        self.moving = true
    elseif xInc ~= 0 or yInc ~= 0 then
        self.moving = true
    end
    if world.collisionCheck(self.x + xInc * dt, self.y + yInc * dt, self.width, self.height) then
        self.x = self.x + xInc * dt
        self.y = self.y + yInc * dt
        --network.updatePos()
    else
        self.moving = false
    end


    if self.moving then
        self.animationStep = self.animationStep + dt
        if self.animationStep > 0.25 then
            if self.quad == self.quads[1] then self.quad = self.quads[2]
            elseif self.quad == self.quads[2] then self.quad = self.quads[1] end
            self.animationStep = 0
        end
    else
        self.quad = self.quads[1]
    end

    if xInc > 0 then
        self.rotation = -1
    elseif xInc < 0 then
        self.rotation = 1
    end
end

return entity