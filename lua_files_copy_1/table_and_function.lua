Lib1 = {}
Lib1.foo = function (x,y) return x + y end
Lib1.goo = function (x,y) return x - y end

Lib2 = {
foo = function (x,y) return x + y end,
goo = function (x,y) return x - y end

}

Lib3 = {}
function Lib3.foo (x,y)
	return x + y
end
function Lib3.goo (x,y)
	return x - y
end

print(Lib1.foo(1,2))
print(Lib2.foo(1,2))
print(Lib3.foo(1,2))
print(Lib1.goo(1,2))
print(Lib2.goo(1,2))
print(Lib3.goo(1,2))