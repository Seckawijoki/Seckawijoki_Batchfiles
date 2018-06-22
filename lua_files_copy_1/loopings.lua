i=0
repeat
 print(i)
 i=i+1
until i>5
print("\r")

for i=5,1,-1 do
print(i)
end
print("\r")

for i=1,5 do
print(i)
end
print("\r")

function f(x)
 return 5
end
for i=1,f(x) do
 print(i)
end
print("\r")

a={1,2,3,4,5,n=5}
value = 3
local found = nil
for i=1,a.n do
if a[i] == value then
found = i -- save value of 'i'
break
end
end
print(found)
print("\r")
