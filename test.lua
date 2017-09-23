local List = require("zfp/List_FP")
local new1 = List.new(1, 3, 4, 5):map( function(a) return a * 2 end)
local new2 = List.new(1, 9, 7, 3, 4, 5)
local qSort
qSort = function(list)
    if (list:length() < 2) then
        return list
    else
        return qSort(list:filter( function(a) return a < list:head() end))
        + list:filter( function(a) return a == list:head() end)
        + qSort(list:filter( function(a) return a > list:head() end))
    end
end
local new3 = qSort(new1 + new2)
local new4 = new3:reduce( function(a, b) return a + b end)
print("====new1 map====")
new1:toString()
print("====new2 foreach====")
new2:foreach(print)
print("====new3 qSort====")
new3:toString()
print("====new4 reduce====")
print(new4)
