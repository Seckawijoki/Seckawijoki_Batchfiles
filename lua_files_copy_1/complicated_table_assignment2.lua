a = { }
b = { x = 1, ["hello, "] = "world!" }
a.astring = "ni, hao!"
a[1] = 100
a["a table"] = b
function foo()
end
function bar()
end
a[foo] = bar
--分别穷举表a和b
for k, v in pairs(a) do
	print(k, "=>", v)
end
print("----------------------------")
for k, v in pairs(b) do
	print(k, "=>", v)
end