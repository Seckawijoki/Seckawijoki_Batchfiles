function create(name, id)
	local data = { name = name, id = id
}
local obj = {}
function obj.SetName(name)
	data.name = name
end
function obj.GetName()
	return data.name
end
function obj.SetId(id)
	data.id = id
end
function obj.GetId()
	return data.id
end
return obj
end
o1 = create("Sam", 001)
o2 = create("Bob", 007)
o1.SetId(100)
print("o1's id:", o1.GetId(), "o2's id:",
	o2.GetId())
o2.SetName("Lucy")
print("o1's name:", o1.GetName(),
	"o2's name:", o2.GetName())