world = {}

world.x = 0
world.y = 0
world.scale = 5
world.spritesheet = love.graphics.newImage("sprites/world.png")
world.quad = love.graphics.newQuad(0, 0, world.spritesheet:getWidth(), world.spritesheet:getHeight(), world.spritesheet:getDimensions())

function world.collisionCheck(x, y, width, height)
    if x >= 0 and x + width <= world.spritesheet:getWidth()   and   y >= -10 and y + height <= world.spritesheet:getHeight() then
        return true
    end
    return false
end

return world