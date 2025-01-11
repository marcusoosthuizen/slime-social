C = {}

function C.get(a, b)
    
    if a[1] >= b[1] and a[1] <= b[1] + b[3]  and  a[2] >= b[2] and a[2] <= b[2] + b[4] then
        return true
    end
    if a[1] + a[3] >= b[1] and a[1] + a[3] <= b[1] + b[3]  and  a[2] + a[4] >= b[2] and a[2] + a[3] <= b[2] + b[4] then
        return true
    end

    if a[1] >= b[1] and a[1] <= b[1] + b[3]  and  a[2] + a[4] >= b[2] and a[2] + a[3] <= b[2] + b[4] then
        return true
    end
    if a[1] + a[3] >= b[1] and a[1] + a[3] <= b[1] + b[3]  and  a[2] >= b[2] and a[2] <= b[2] + b[4] then
        return true
    end
    return false
end

function C.getAll(a, c)
    for i = 1, #c, 1
    do
        b = c[i]

        if a[1] >= b[1] and a[1] <= b[1] + b[3]  and  a[2] >= b[2] and a[2] <= b[2] + b[4] then
            return true
        end
        if a[1] + a[3] >= b[1] and a[1] + a[3] <= b[1] + b[3]  and  a[2] + a[4] >= b[2] and a[2] + a[3] <= b[2] + b[4] then
            return true
        end
    
        if a[1] >= b[1] and a[1] <= b[1] + b[3]  and  a[2] + a[4] >= b[2] and a[2] + a[3] <= b[2] + b[4] then
            return true
        end
        if a[1] + a[3] >= b[1] and a[1] + a[3] <= b[1] + b[3]  and  a[2] >= b[2] and a[2] <= b[2] + b[4] then
            return true
        end
    end
    
    
end

-- TO DO LATER BECAUSE THIS IS TOO FRICKING FRUSTRATING

--[[function axis(a, b)
    if a[1] <= b[1] + b[3] or a[1] + a[3] >=b[1] then
        temp = "x"
    elseif a[2] <= b[2] + b[4] or a[2] + a[4] >=b[2] then
        if temp == "x" then
            print("both")
            return "both"
        else 
            print("y")
            return "y"
        end
    else
        print("x")
        return "x"
    end
end]]--

return C

--[[function C.get(a, b)
    if a[1] >= b[1] and a[1] <= b[1] + b[3]  and  a[2] >= b[2] and a[2] <= b[2] + b[4] then
        return true
    end
    if a[1] + a[3] >= b[1] and a[1] + a[3] <= b[1] + b[3]  and  a[2] + a[4] >= b[2] and a[2] + a[3] <= b[2] + b[4] then
        return true
    end

    if a[1] >= b[1] and a[1] <= b[1] + b[3]  and  a[2] + a[4] >= b[2] and a[2] + a[3] <= b[2] + b[4] then
        return true
    end
    if a[1] + a[3] >= b[1] and a[1] + a[3] <= b[1] + b[3]  and  a[2] >= b[2] and a[2] <= b[2] + b[4] then
        return true
    end
    return false
end]]--