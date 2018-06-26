days = {"Sunday", "Monday", "Tuesday", "Wednesday",
"Thursday", "Friday", "Saturday"}
--Lua 将"Sunday"初始化 days[1]（第一个元素索引为 1），用"Monday"初始化 days[2]...
print(days[4])
print("\r")

sin = math.sin

tab = {sin(1), sin(2), sin(3), sin(4),
sin(5),sin(6), sin(7), sin(8)}
--如果想初始化一个表作为 record 使用可以这样：
a = {x=0, y=0} --> a = {}; a.x=0; a.y=0

w = {x=0, y=0, label="console"}
print(w[1])
print(w[2])
print(w[3])
x = {sin(1), sin(2), sin(3)}
print(x[1])
print(x[2])
print(x[3])
w[1] = "another field"
x.f = w
print(w["x"]) --> 0
print(w[1]) --> another field
print(x.f[1]) --> another field
w.x = nil -- remove field "x"
print(w.x)