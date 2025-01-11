camera = {}

camera.x = player.x
camera.y = player.y
camera.width = 192
camera.height = 128

function camera.update(ex, ey, ew, eh, er, dt)
    cnrx = (ex + ew / 2 * er - 75)
    cnry = (ey + eh / 2 - 50)
    
    dx = ex + ew / 2 * er - camera.x - 75
    dx = dx * 4 -- = speed
    dy = ey + eh / 2 - camera.y - 50
    dy = dy * 4 -- = speed
    camera.x = camera.x + dx * dt
    camera.y = camera.y + dy * dt


    if camera.x < world.x then
        camera.x = 0
    end
    if camera.x + camera.width > world.x + world.spritesheet:getWidth() then
        camera.x = world.x + world.spritesheet:getWidth() - camera.width
    end

    if camera.y < world.y then
        camera.y = 0
    end
    if camera.y + camera.height > world.y + world.spritesheet:getHeight() then
        camera.y = world.y + world.spritesheet:getHeight() - camera.height
    end
    
end

return camera