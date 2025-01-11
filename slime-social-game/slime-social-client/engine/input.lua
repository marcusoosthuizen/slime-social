local input = {}

local prevKeys = {}
local newKeys = {}

function input.get()
    local keys = {}
    local index = 0
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        keys[index] = "up"
        index = index + 1
    end
    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        keys[index] = "down"
        index = index + 1
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        keys[index] = "left"
        index = index + 1
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        keys[index] = "right"
        index = index + 1
    end

    if love.keyboard.isDown("1") then
        --cht.preset("1")
    end
    if love.keyboard.isDown("2") then
        --cht.preset("2")
    end
    if love.keyboard.isDown("3") then
        --cht.preset("3")
    end
    if love.keyboard.isDown("4") then
        --cht.preset("4")
    end
    if love.keyboard.isDown("5") then
        --cht.preset("5")
    end
    if love.keyboard.isDown("6") then
        --cht.preset("6")
    end
    if love.keyboard.isDown("t") then
        mode = 2
        table.insert(prevKeys, "t")
    end

    if love.keyboard.isDown("b") then
        keys[index] = "b"
        index = index + 1
    end
    return keys
end

function input.type()
    local keys = ""
    local pressed = false
    local keysCheck = {"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m","1","2","3","4","5","6","7","8","9","0","-","=","/","'",",",".","space","backspace"}
    --local capsKeys = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","1","2","3","4","5","6","7","8","9","0","-","=","/","'",",",".","space","backspace"}
    local shiftKeys = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","!","@","#","$","%","^","&","*","(",")","_","+","?",'"',"<",">","space","backspace"}
    for i = 1, #keysCheck, 1
    do  
        if love.keyboard.isDown(keysCheck[i]) then
            pressed = true
            if prevKeys[1] ~= keysCheck[i] then
                if keysCheck[i] ~= "space" then
                    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
                        keys = shiftKeys[i]
                    else
                        keys = keysCheck[i]
                    end
                
                elseif daName ~= "" then
                    keys = " "
                end
            end
            table.insert(newKeys, keysCheck[i])
        end
        if keysCheck[i] == prevKeys[1] then 
            table.remove(prevKeys, 1)
        end
    end
    if love.keyboard.isDown("return") then
        if daName ~= "" then
            chat.send(typedMessage, daName)
            chat.gsend(typedMessage)
            typedMessage = ""
            mode = 1
        else
            daName = typedMessage
            player.name = typedMessage
            typedMessage = ""
            mode = 1
        end
    elseif love.keyboard.isDown("escape") and daName ~= "" then
        mode = 1
        typedMessage = ""
    end
    
    if pressed == false then
        newKeys = {}
    end
    prevKeys = newKeys
    newKeys = {}

    return keys
end

return input
