Robot = { name = "Sam", id = 001 }
function Robot:New(extension)
	local t = setmetatable(extension or { }, self)
	self.__index = self
	return t
end
function Robot:SetName(name)
	self.name = name
end
function Robot:GetName()
	return self.name
end
function Robot:SetId(id)
	self.id = id
end
function Robot:GetId()
	return self.id
end
robot = Robot:New()
print("robot's name:", robot:GetName())
print("robot's id:", robot:GetId())
print("-----------------")
FootballRobot = Robot:New(
	{position = "right back"})
function FootballRobot:SetPosition(p)
	self.position = p
end
function FootballRobot:GetPosition()
	return self.position
end
fr = FootballRobot:New()
print("fr's position:", fr:GetPosition())
print("fr's name:", fr:GetName())
print("fr's id:", fr:GetId())
print("-----------------")
fr:SetName("Bob")
print("fr's name:", fr:GetName())
print("robot's name:", robot:GetName())