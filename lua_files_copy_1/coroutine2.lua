function instream()
	return coroutine.wrap(function()
		while true do
			local line = io.read("*l")
			if line then
				coroutine.yield(line)
			else
				break
			end
		end
		end)
end
function filter(ins)
	return coroutine.wrap(function()
		while true do
			local line = ins()
			if line then
				line = "** " .. line .. " **"
				coroutine.yield(line)
			else
				break
			end
		end
		end)
end
function outstream(ins)
	while true do
		local line = ins()
		if line then
			print(line)
		else
			break
		end
	end
end
outstream(filter(instream()))