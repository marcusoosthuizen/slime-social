chat = {}

chat.list = {}
chat.predt = 1

function chat.send(message, name)
    table.insert(chat.list, {message, 0, name})
    if #chat.list == 6 then
        table.remove(chat.list, 1)
    end
end

function chat.gsend(message)
    msg = "C " .. tostring(daName) .. " " .. tostring(message)
    udp:send(msg)
end

--chat.send("Marcus - why are you such a sussy baka")
--chat.send("Rimjo - no u")
--chat.send("Blobby - wait what is happening????")
--chat.send("Imposter has joined the game...")
--chat.send("Kris - nani?!")
--chat.send("Imposter - Allow me to introduce myself")

function chat.update(dt)
    local rmlist = {}
    for i = 1, #chat.list, 1
    do
        chat.list[i][2] = chat.list[i][2] + dt
        --print(chat.list[i][1])
        if chat.list[i][2] >= 5 then
            table.insert(rmlist, i)
        end
    end
    for i = 1, #rmlist, 1
    do
        table.remove(chat.list, rmlist[i])
    end

    chat.predt = chat.predt + dt

end

function chat.get()
    local renderlist = {}
    local empty = true
    for i = 1, #chat.list, 1
    do
        local opacity = 1
        if chat.list[i][2] > 3 then
            opacity = 1 - (chat.list[i][2] - 3) / 2
        end
        table.insert(renderlist, {chat.list[i][1], opacity, chat.list[i][3]})
        empty = false
    end
    if empty == false then return renderlist end
end

function chat.preset(num)
    if chat.predt > 1 then
        chat.predt = 0
        if num == "1" then
            chat.send("Hello friend!", daName)
            chat.gsend("Hello friend!")
        end
        if num == "2" then
            chat.send("!", daName)
            chat.gsend("!")
        end
        if num == "3" then
            chat.send("What did I do?", daName)
            chat.gsend("what did I do?")
        end
        if num == "4" then
            chat.send("I am happy!", daName)
            chat.gsend("I am happy!")
        end
        if num == "5" then
            chat.send("I am sad...", daName)
            chat.gsend("I am sad...")
        end
        if num == "6" then
            chat.send("Bye bye!", daName)
            chat.gsend("Bye bye!")
        end
    end
end

return chat