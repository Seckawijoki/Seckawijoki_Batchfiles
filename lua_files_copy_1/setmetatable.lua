t = {}
m = { a = " and ", b = "Li Lei", c = "Han Meimei" }
setmetatable(t, { __index = m}) --表{ __index=m }作为表t的元表
for k, v in pairs(t) do --穷举表t
	print(k, v)
end
print("-------------")
print(t.b, t.a, t.c)