local M = { }
local tUnpack = table.unpack
M.combinefunc = function(func1, func2)
	return function(...)
		func1(func2(...))
	end
end
return M
