def parse(term)
    symbol = term[0]
    if symbol == "[" 
        n = term.length
        mid = 0
        for i in (1..n) do
            if term[i] == "]"
                mid = i
                break
            end
        end
        left = term[1..i-1]
        right = term[i+2..n-2]
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
        # all symbols has to be variables 
        n = term.length
        if n == 1
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
    

if parse(term3) 
    puts "Yes, given term is valid lambda term"
else 
    puts "No"
end