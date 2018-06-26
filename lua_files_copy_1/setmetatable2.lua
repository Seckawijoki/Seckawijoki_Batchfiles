function add(t1, t2)
--‘#’运算符取表长度
assert(#t1 == #t2)
local length = #t1
for i = 1, length do
	t1[i] = t1[i] + t2[i]
end
return t1
end
--setmetatable返回被设置的表
t1 = setmetatable({ 1, 2, 3}, { __add
	= add })
t2 = setmetatable({ 10, 20, 30 }, {
	__add = add })
t1 = t1 + t2
for i = 1, #t1 do
	print(t1[i])
end