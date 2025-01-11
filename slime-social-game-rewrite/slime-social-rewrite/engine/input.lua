i = {}

function i.get()
    local keys = {}
    if mode == 1 then
        if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
            table.insert(keys, "up")
        end
        if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
            table.insert(keys, "down")
        end
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            table.insert(keys, "left")
        end
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            table.insert(keys, "right")
        end
        if love.keyboard.isDown("t") then
            mode = 2
            table.insert(bubbles, bb:new(nil))
            bubbles[#bubbles]:init(player.x, player.y, 0)
            bubbles[#bubbles]:update(0)
            bubbles[#bubbles]:redraw("")
        end
    elseif mode == 2 then
        if love.keyboard.isDown("return") then
            mode = 1
        end
        if love.keyboard.isDown("escape") then
            mode = 1
            for i = 1, #bubbles, 1 do
                if bubbles[i].index == 0 then
                    bubbles[i].life = 0
                end
            end
        end
        if love.keyboard.isDown("backspace") then
            for i = 1, #bubbles, 1 do
                if bubbles[i].index == 0 then
                    bubbles[i]:backspace()
                end
            end
        end
    end

    return keys
end

function love.textinput(text)
    if mode == 2 then
        for i = 1, #bubbles, 1
        do
            if bubbles[i].index == 0 then
                bubbles[i]:redraw(text)
            end
        end
    end
end

return i