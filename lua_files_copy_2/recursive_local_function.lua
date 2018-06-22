local fact
fact = function (n)
	if n == 0 then
		return 1
	else
		return n*fact(n-1) -- buggy
	end
end

print(fact(5))