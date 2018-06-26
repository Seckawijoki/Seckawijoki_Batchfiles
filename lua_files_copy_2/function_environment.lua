function foo()
	print(g or "No g defined!")
end
foo = foo()
foo()
setfenv(foo, { g = 100, print = print }) --设置foo的环境为表{ g=100, ...}
foo()
print(g or "No g defined!")