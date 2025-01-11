button = {}
local font = love.graphics.newFont("fonts/pressstart.ttf", 16)

function button:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function button:init(name, x, y, bFunc)
    self.name = name
    self.x = x
    self.y = y
    self.width = 15
    self.height = 10
    self.bFunc = bFunc
end

function button:check(mouseX, mouseY)
    if mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height and love.mouse.isDown(1) then
        if bFunc == 1 then
            mode = 2
        end
    end
end

return button