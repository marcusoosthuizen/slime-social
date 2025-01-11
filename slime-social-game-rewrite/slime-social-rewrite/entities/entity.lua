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
    self.width, self.height = 20
    self.sprite = love.image.load("sprite/player.png")
end

return entity