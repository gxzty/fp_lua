local M = { }
local os = os
local now = os.time
local timeList = { }
local timeTemp = { }
local index = 1

M.register = function(timeName)
	local timeNode = { name = timeName, index = index }
	tInsert(timeList, timeNode)
	index = index + 1
	assert(#timeList == index)
end

M.stop = function(timeName)
--	timeList[timeName]
end

return M
