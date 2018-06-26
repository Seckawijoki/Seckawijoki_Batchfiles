print(4 and 5) --> 5
print(nil and 13) --> nil
print(false and 13) --> false
print(4 or 5) --> 4
print(false or 5) --> 5
print("\n")

v = "value"
x = x or v
print(x)
print("\n")

a = true
b = "b"
c = "c"
print((a and b) or c) -- a ? b : c
a = false
print((a and b) or c) -- a ? b : c
print("\n")

print(not nil) --> true
print(not false) --> true
print(not 0) --> false
print(not not nil) --> false
print("\n")