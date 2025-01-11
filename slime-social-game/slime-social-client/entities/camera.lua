local cm = {}

function cm.init(x, y)
    cm.x = x
    cm.y = y
    cm.width = 150
    cm.height = 100

end

function cm.update(ex, ey, ew, eh, er, speed, mode, dt)
    cnrx = (ex + ew / 2 * er - 75)
    cnry = (ey + eh / 2 - 50)
    if mode == "fixed" then
        cm.x = cnrx
        cm.y = cnry
    elseif mode == "smooth" then
        dx = ex + ew / 2 * er - cm.x - 75
        dx = dx * speed
        dy = ey + eh / 2 - cm.y - 50
        dy = dy * speed
        cm.x = cm.x + dx * dt
        cm.y = cm.y + dy * dt

        --diffy = 10000
        --if ey > cm.y then diffy = ey - cm.y - 42 end
        --if ey < cm.y then diffy = cm.y - ey - 42 end
        --if diffy < 1 then cm.y = math.ceil(cm.y) end
    
    end
    
end

return cm