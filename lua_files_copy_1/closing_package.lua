names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}
for k, v in pairs(names) do
	print(k,v)
end
print("\r")
function sortbygrade (names, grades)
	table.sort(names, 
		function (n1, n2)
			return grades[n1] > grades[n2] -- compare the grades
		end
	)
end
sortbygrade(names, grades)
for k, v in pairs(names) do
	print(k,v)
end