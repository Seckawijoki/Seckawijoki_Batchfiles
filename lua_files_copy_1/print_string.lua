a = "one string"
b = string.gsub(a, "one", "another") -- change string parts
print(a) -- one string
print(b)
a = "a line"
b = 'another line'
print(a)
print(b)
print("one line\nnext line\n\"in quotes\", 'in quotes'")
print('a backslash inside quotes: \'\\\'')
print("a simpler way: '\\'")
page = [==[
<HTML>
<HEAD>
<TITLE>An HTML Page</TITLE>
</HEAD>
<BODY>
Lua
[[a text between double brackets]]
</BODY>
</HTML>
]==]
io.write(page)