local M = { }
local print = print
local index = 1
M.indexPrint = function(str)
	print("====new"..index.." "..str.."====")
	index = index + 1
end
return M
