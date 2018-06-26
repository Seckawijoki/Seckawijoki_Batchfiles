--[=[
printResult = ""
function print(...)
for i,v in ipairs(arg) do
printResult = printResult .. tostring(v) .. "\t"
end
printResult = printResult .. "\n"
end
]=]--

function g (a, b, ...) 
  print(a,b,arg)
end

g(3) -- a=3, b=nil, arg={n=0}
g(3, 4) -- a=3, b=4, arg={n=0}
g(3, 4, 5, 8) -- a=3, b=4, arg={5, 8; n=2}

function select (n, ...)
return arg[n]
end
print(string.find("hello hello", " hel")) --> 6 9
print(select(1, string.find("hello hello", " hel"))) --> 6
print(select(2, string.find("hello hello", " hel"))) --> 9