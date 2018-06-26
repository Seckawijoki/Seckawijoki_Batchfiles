opnames = {["+"] = "add", ["-"] = "sub",
["*"] = "mul", ["/"] = "div"}
i = 20; s = "-"
a = {[i+0] = s, [i+1] = s .. s, [i+2] = s .. s .. s}
print(opnames[s]) --> sub
print(a[22]) --> ---

t0 = {x=0, y=0} --> {["x"]=0, ["y"]=0}
t1 = {"red", "green", "blue"} --> {[1]="red", [2]="green", [3]="blue"}

days = {[0]="Sunday", "Monday", "Tuesday", "Wednesday"
"Thursday", "Friday", "Saturday"}

a = {[1]="red", [2]="green", [3]="blue",}

t2 = {x=10, y=45; "one", "two", "three"}