def findMid(term)
    mid = 0
    n = term.length
    count = 1
    for i in (1..n) do
        if term[i] == "["
            count = count + 1
        end
        if term[i] == "]"
            count = count-1
            if count == 0
                mid = i
                break
            end
        end
    end
    return mid
end

def parse(term)
    symbol = term[0]
    if symbol == "[" 
        n = term.length
        mid = findMid(term)
        
        left = term[1..mid-1]
        right = term[mid+2..n-2]
        return parse(left) && parse(right)
    elsif symbol == "("
        if term[1] != "\\" || term[3] != "."
            return false
        end 
        n = term.length
        if term[n-1] != ")" 
            return false
        end
        tempLambda = term[4..n-2]
        return parse(tempLambda)
    else
        n = term.length
        if n == 1 && term[0] < 'z' && term[0] > 'a'
            return true
        else
            return false
        end    
        tempLambda = term[1..n]
        return parse(tempLambda)    
    end 
end

term1 = "x"
term2 = "(\\x." + term1 +")"
term3 = "[" + term1 + "][" + term2 + "]"
term4 = "[" + term3 + "][" + term2 + "]"

if parse(term3) 
    puts "Yes, given term is valid lambda term"
else 
    puts "No"
end