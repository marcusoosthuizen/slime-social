render = {}

love.graphics.setDefaultFilter("nearest", "nearest")
render.font = love.graphics.newFont("fonts/pressstart.ttf", 20)
render.font2 = love.graphics.newFont("fonts/pressstart.ttf", 16)
render.font3 = love.graphics.newFont("fonts/pressstart.ttf", 32)
render.font4 = love.graphics.newFont("fonts/pressstart.ttf", 24)

love.graphics.setFont(render.font)

local speechStart = love.graphics.newImage("sprites/speech-start.png")
local speechMid = love.graphics.newImage("sprites/speech-mid.png")
local speechEnd = love.graphics.newImage("sprites/speech-end.png")

function render.drawCenteredText(rectX, rectY, rectWidth, rectHeight, text)
	love.graphics.push()
    love.graphics.setColor(0, 0, 0)
    love.graphics.scale(1/6, 1/6)
    love.graphics.setFont(render.font)
    local font       = render.font
	local textWidth  = font:getWidth(text)
	local textHeight = font:getHeight()
    love.graphics.print(text, (rectX+rectWidth/2) * 6, (rectY+rectHeight/2) * 6, 0, 1, 1, textWidth/2, textHeight/2)
    love.graphics.pop()
    love.graphics.setColor(255, 255, 255)
end

function render.RegularText(item, x, y)
    love.graphics.push()
    love.graphics.setColor(0, 0, 0)
    love.graphics.scale(1/6, 1/6)
    love.graphics.setFont(render.font2)
    local font       = render.font2
    local textHeight = font:getHeight()
    love.graphics.print(item, x, y)
    love.graphics.pop()
    love.graphics.setColor(255, 255, 255)
end

function render.draw(queue, cam)
    
    love.graphics.scale(6, 6)
    
    for i = 1, #queue, 1
    do
        local item = queue[i]
        if item[4] == nil then
            love.graphics.draw(item[3], item[1] - cam[1], item[2] - cam[2])
        elseif item[7] == "pl" then
            love.graphics.draw(item[4], item[5], item[1] - cam[1], item[2] - cam[2], 0, item[3], 1)
            if item[3] == -1 then
                render.drawCenteredText(item[1] - cam[1] - 20, item[2] - cam[2] + 20, 20, 10, item[6])
                if item[8] then 
                    love.graphics.setColor(255, 255, 255, item[11]) 
                    love.graphics.draw(speechStart, item[1] - cam[1], item[2] + 2 - cam[2]) 
                    love.graphics.draw(speechMid, item[1] + 3 - cam[1], item[2] + 2 - cam[2], 0, item[10], 1)
                    love.graphics.draw(speechEnd, item[1] + 3 + item[10] - cam[1], item[2] + 2 - cam[2])
                    render.RegularText(item[9], (item[1] + 3 - cam[1]) * 6, (item[2] + 4 - cam[2]) * 6) 
                    love.graphics.setColor(255, 255, 255) 
                end
            else
                render.drawCenteredText(item[1] - cam[1], item[2] - cam[2] + 20, 20, 10, item[6])
                if item[8] then
                    love.graphics.setColor(255, 255, 255, item[11]) 
                    love.graphics.draw(speechStart, item[1] + 16 - cam[1], item[2] + 2 - cam[2]) 
                    love.graphics.draw(speechMid, item[1] + 19 - cam[1], item[2] + 2 - cam[2], 0, item[10], 1)
                    love.graphics.draw(speechEnd, item[1] + 19 + item[10] - cam[1], item[2] + 2 - cam[2])
                    render.RegularText(item[9], (item[1] + 19 - cam[1]) * 6, (item[2] + 4 - cam[2]) * 6) 
                    love.graphics.setColor(255, 255, 255) 
                end
            end
        else
            love.graphics.draw(item[4], item[5], item[1] - cam[1], item[2] - cam[2], 0, item[3], 1)
            if item[3] == -1 then
                render.drawCenteredText(item[1] - cam[1] - 20, item[2] - cam[2] + 20, 20, 10, item[6])
                if item[7] then 
                    love.graphics.draw(speechStart, item[1] - cam[1], item[2] + 2 - cam[2]) 
                    love.graphics.draw(speechMid, item[1] + 3 - cam[1], item[2] + 2 - cam[2], 0, item[9], 1)
                    love.graphics.draw(speechEnd, item[1] + 3 + item[9] - cam[1], item[2] + 2 - cam[2])
                    render.RegularText(item[8], (item[1] + 3 - cam[1]) * 6, (item[2] + 4 - cam[2]) * 6) 
                end
            else
                render.drawCenteredText(item[1] - cam[1], item[2] - cam[2] + 20, 20, 10, item[6])
                if item[7] then 
                    love.graphics.draw(speechStart, item[1] + 16 - cam[1], item[2] + 2 - cam[2]) 
                    love.graphics.draw(speechMid, item[1] + 19 - cam[1], item[2] + 2 - cam[2], 0, item[9], 1)
                    love.graphics.draw(speechEnd, item[1] + 19 + item[9] - cam[1], item[2] + 2 - cam[2])
                    render.RegularText(item[8], (item[1] + 19 - cam[1]) * 6, (item[2] + 4 - cam[2]) * 6) 
                end
                
            end
        end
    end
    
    
    
end



function render.chat(queue)
    if queue ~= nil then
        for i = #queue, 1, -1
        do
            local truei = #queue - i + 1
            love.graphics.push()
            love.graphics.setColor(0, 0, 0, queue[i][2] - (truei - 1) / 8)
            love.graphics.scale(1/6, 1/6)
            love.graphics.setFont(render.font2)
            local font       = render.font2
            local textHeight = font:getHeight()
            love.graphics.print(queue[i][3] .. " - " .. queue[i][1], 2 * 6, (100 - 1 - (textHeight - 1 * 6) * truei / 6) * 6)
            love.graphics.pop()
            love.graphics.setColor(255, 255, 255)

            --love.graphics.draw(speechStart, )
        end
    end
end

local playerSprite = love.graphics.newImage("sprites/player.png")

function render.menu()
    love.graphics.setFont(render.font3)
    love.graphics.print("Slime Social", 450 - render.font3:getWidth("Slime Social") / 2, 40)
    love.graphics.setFont(render.font4)
    love.graphics.print("Join", 450 - render.font4:getWidth("Join") / 2, 250)
    love.graphics.print("Host", 450 - render.font4:getWidth("Host") / 2, 300)
    love.graphics.print("Settings", 450 - render.font4:getWidth("Settings") / 2, 350)

    love.graphics.setFont(render.font)
    love.graphics.print(version, 890 - render.font:getWidth(version), 590 - render.font:getHeight())
    
    love.graphics.draw(playerSprite, 825, 475, 0, 4, 4)
end


return render