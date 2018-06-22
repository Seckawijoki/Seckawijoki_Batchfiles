function addition()
	local t = 0
	return function ()
		t = t + 1
		return t
	end
end

add = addition()
print(add())
print(add())
print(add())