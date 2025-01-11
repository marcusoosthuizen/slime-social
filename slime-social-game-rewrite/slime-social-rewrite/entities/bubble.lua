entity = {}

function entity:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function entity:init(x, y, index)
    self.x = x
    self.y = y
    self.sprites = {love.graphics.newImage("sprites/speech-start.png"), love.graphics.newImage("sprites/speech-mid.png"), love.graphics.newImage("sprites/speech-end.png")}

    self.spritesheet = love.graphics.newCanvas(800, 40)

    self.quad = love.graphics.newQuad(0, 0, self.spritesheet:getWidth(), self.spritesheet:getHeight(), self.spritesheet:getDimensions())
    self.scale = 1

    self.text = ""
    self.index = index
    self.font = love.graphics.newFont("engine/font.ttf", 15)
    self.alpha = 1

    self.life = 6

    self.etimer = 1
end

function entity:update(dt)
    if self.index == 0 then
        self.x = player.x + 15 + ((player.rotation - 1) * -0.5) * 5
        self.y = player.y + 3
        if mode == 2 then
            self.alpha = 0.75
        end
    else
        --Multiplayer Code
    end
        
    if mode == 1 or self.index ~= 0 then
        self.life = self.life - dt
        self.alpha = self.life * 2
        self:redraw("")
    end

    if self.etimer < 0.15 then
        self.etimer = self.etimer + dt
    end
end

function entity:redraw(text)

    self.text = self.text .. text

    love.graphics.setCanvas(self.spritesheet)
    
    love.graphics.clear()
    love.graphics.setColor(255, 255, 255, self.alpha)
    love.graphics.draw(self.sprites[1], 0, 0, 0, 5, 5)
    love.graphics.draw(self.sprites[2], self.sprites[1]:getWidth() * 5, 0, 0, (self.font:getWidth(self.text) + 5), 5)
    love.graphics.draw(self.sprites[3], self.sprites[1]:getWidth() * 5 + self.font:getWidth(self.text) + self.sprites[2]:getWidth() * 5, 0, 0, 5, 5)
    
    love.graphics.setFont(self.font)
    love.graphics.setColor(0, 0, 0, self.alpha)
    love.graphics.print(self.text, self.sprites[1]:getWidth() * 5, 10)
    love.graphics.setColor(255, 255, 255)

    love.graphics.setCanvas()
end

function entity:backspace()
    if self.etimer >= 0.15 then
        self.text = self.text:sub(1, -2)
        self.etimer = 0
        self:redraw("")
    end
end

return entity