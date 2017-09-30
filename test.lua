local p = require("zfp/utils/print").indexPrint
local List = require("zfp/List_FP")
local new1 = List.new(1, 3, 4, 5):map("__ * 2")
local new2 = List.new(1, 9, 7, 3, 4, 5)
local new3 = new1 + new2
local new4 = new3:sort()
local new5 = new4:reduce( function(a, b) return a + b end)
local new6 = List.new(List.new(-1,-2,List.new(-3,0,List.new(1,2,3,4),3),-4,-5),List.new(1,2,3,4,5))
local new7 = new6:flatten()
local new8 = new7:invert()

p("map")
new1:toString()

p("foreach")
new2:foreach(print)

p("add")
print(new3)

p("sort")
print(new4)

p("reduce")
print(new5)

p("nest")
print(new6[1][3][3])

p("flatten")
print(new7)

p("invert")
print(new8)
