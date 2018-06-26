function enum(array)
	return coroutine.wrap(function()
		local len = #array
		for i = 1, len do
			coroutine.yield(array[i])
		end
		end)
end
function foreach(array, action)
	for element in enum(array) do
		action(element)
	end
end
foreach({1, 2, 3}, print)