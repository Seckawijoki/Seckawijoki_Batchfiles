function createRobot(name, id)
	local obj = { name = name, id = id }
	function obj:SetName(name)
		self.name = name
	end
	function obj:GetName()
		return self.name
	end
	function obj:GetId()
		return self.id
	end
	return obj
end
function createFootballRobot(name,id, position)
	local obj = createRobot(name, id)
	obj.position = "right back"
	function obj:SetPosition(p)
		self.position = p
	end
	function obj:GetPosition()
		return self.position
	end
	return obj
end