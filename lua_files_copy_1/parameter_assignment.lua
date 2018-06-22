x=1
y=-1
a, b = 10, 2*x
print(a)
print(b)
print("\r")

function f()
return "a","b"
end
a, b, c = 0, 1
print(a,b,c,"\r") --> 0 1 nil
a, b = a+1, b+1, b+2 -- value of b+2 is ignored
print(a,b,"\r") --> 1 2
a, b, c = 0
print(a,b,c,"\r") --> 0 nil nil

a, b = f()
print(a,b,"\r")