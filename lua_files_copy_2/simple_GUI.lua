function Window (options)
-- check mandatory options
if type(options.title) ~= "string" then
	error("no title")
elseif type(options.width) ~= "number" then
	error("no width")
elseif type(options.height) ~= "number" then
	error("no height")
end
-- everything else is optional

w = Window {
x=0, y=0, width=300, height=200,
title = "Lua", background="blue",
border = true
}

_Window(options.title,
options.x or 0, -- default value
options.y or 0, -- default value
options.width, options.height,
options.background or "white", -- default
options.border -- default is false (nil)
)
end