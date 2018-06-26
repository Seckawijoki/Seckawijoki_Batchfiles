oldSin = math.sin
math.sin = function (x) -- 使用度数
	return oldSin(x*math.pi/180)
end

print(math.sin(3.14))
print(math.sin(30))