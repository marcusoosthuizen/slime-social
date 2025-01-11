r = {}
love.graphics.setDefaultFilter("nearest", "nearest")

function r.draw(entities)
    
    for i = 1, #entities, 1
    do
        local entity = entities[i]
        love.graphics.scale(entity.scale, entity.scale)

        local sfix = 5 / entity.scale
        
        if entity.rotation == -1 then
            love.graphics.draw(entity.spritesheet, entity.quad, entity.x - camera.x + entity.width, entity.y - camera.y, 0, entity.rotation, 1)
        else
            love.graphics.draw(entity.spritesheet, entity.quad, entity.x * sfix - camera.x * sfix, entity.y * sfix - camera.y * sfix, 0, entity.rotation, 1)
        end
        
        love.graphics.scale(1 / entity.scale, 1 / entity.scale)
    end
end

return r