days = {"Sunday", "Monday", "Tuesday", "Wednesday",
"Thursday", "Friday", "Saturday"}
--[=[
revDays = {["Sunday"] = 1, ["Monday"] = 2,
["Tuesday"] = 3, ["Wednesday"] = 4,
["Thursday"] = 5, ["Friday"] = 6,
["Saturday"] = 7}
x = "Tuesday"
print(revDays[x]) --> 3
]=]--
revDays = {}
for i,v in ipairs(days) do revDays[v] = i end
for i,v in ipairs(days) do print(i,v) end print("\r")
for j,x in pairs(revDays) do print(j,x) end print("\r")