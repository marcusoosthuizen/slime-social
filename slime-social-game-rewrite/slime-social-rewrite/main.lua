function love.load()
    local pl = require "entities/player"
    bb = require "entities/bubble"
    render = require "engine/render"
    input = require "engine/input"
    world = require "engine/world"
    networking = require "engine/networking"

    player = pl:new(nil)
    player:init(world.spritesheet:getWidth() / 2, world.spritesheet:getHeight() / 2)

    networking.init()

    bubbles = {}

    camera = require "entities/camera"

    love.window.setMode(960, 640)
    love.window.setTitle("Slime Social 0.4")

    mode = 1
end

function love.update(dt)
    player:update(dt)
    camera.update(player.x, player.y, player.width, player.height, -1, dt)

    local rmlist = {}
    for i = 1, #bubbles, 1 do
        bubbles[i]:update(dt)
        if bubbles[i].life <= 0 then
            table.insert(rmlist, i)
        end
    end
    for i = 1, #rmlist, 1 do
        table.remove(bubbles, rmlist[i])
    end
end

function love.draw()
    
    
    render.draw({world, player})
    render.draw(bubbles)


end