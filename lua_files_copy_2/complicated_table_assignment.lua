polyline = {color="blue", thickness=2, npoints=4,
{x=0, y=0},
{x=-10, y=0},
{x=-10, y=1},
{x=0, y=1}
}
--这个例子也表明我们可以嵌套构造函数来表示复杂的数据结构.
print(polyline[2].x) --> -10
print(polyline[2].y) --> -10