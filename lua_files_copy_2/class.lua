function create(name, id)
	local obj = { name = name, id = id }
	function obj:SetName(name)
		self.name = name
	end
	function obj:GetName()
		return self.name
	end
	function obj:SetId(id)
		self.id = id
	end
	function obj:GetId()
		return self.id
	end
	return obj
end
o1 = create("Sam", 001)
print("o1's name:", o1:GetName(),
	"o1's id:", o1:GetId())
o1:SetId(100)
o1:SetName("Lucy")
print("o1's name:", o1:GetName(),
	"o1's id:", o1:GetId())