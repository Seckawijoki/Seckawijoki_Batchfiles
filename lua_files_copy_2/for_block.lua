a={1,2,3,4,5}
-- print all values of array 'a'
for i,v in ipairs(a) do print(v) end
print("\r")

-- print all keys of table 't'
t={1,2,3,"a","b","c",3.14,6.28,9.42,true,false}
for k in pairs(t) do print(k) end
print("\r")