a={};a.x=1;a.y=0
b={};b.x=1;b.y=0
c=a
print(a==c)--> true
print(a~=c)--> false
print(a==b)--> false
print(a~=b)--> true

print(tostring(10) == "10") --> true
print(10 .. "" == "10")--> true