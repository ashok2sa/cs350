require 'set'
def lambda_seprator s
    sum = 0
    tmp = ""
    res = []
    s.each_char do |i|
        tmp = tmp + i.to_s
        if i == '('
            sum += 1
        elsif i == ')'
            sum -= 1
        end

        if sum == 0
            res << tmp
            tmp = ""
        end
    end
    return res
end

def is_valid_char? ch 
    if ch == '.' or ch == '\\' or (ch>='a' and ch<='z') or ch == '(' or ch == ')' 
        return true
    else
        return false
    end 
end

def is_alpha? ch
    if ch >= 'a' and ch <= 'z'
        return true
    end
    return false
end

def is_valid? s
    nterm = s.count('(')
    if s.count('.') != nterm or s.count('\\') != nterm
        return false
    end
    stack = []
    s.each_char do |i|
        if !is_valid_char? i
            return false
        end
        if i != ')'
            stack.append i
        else
            while !stack.empty? and stack.last != '('
                stack.pop
            end
            if stack.empty?
                return false
            end
            stack.pop
        end
    end
    
    return stack.empty?
end


def FV_basic s 
    bound = Set.new
    fv = Set.new
    dotfound = false
    s.each_char do |i|
        if i == '.'
            dotfound = true
            next
        end
        if dotfound == true
            if is_alpha? i and !bound.include? i
                fv << i 
            end 
        else 
            if is_alpha? i
                bound << i 
            end 
        end
    end
    fv.to_a
end
def FV s
    a = lambda_seprator s 
    fv = Set.new
    a.each do |i|
        curr = FV_basic i 
        curr.each do |ch|
            fv << ch
        end
    end
    return fv.to_a
end




s = gets.chomp
p FV s