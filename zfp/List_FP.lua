local List = { }
local tInsert = table.insert
List.new = function(...)
    local _list = { }
    _list._ = {...}
    _list.length = function(self)
        return #self._
    end
    _list.head = function(self)
        return self._[1]
    end
    _list.toString = function(self)
        print(tostring(self))
    end
    _list.push = function(self, data)
        if (type(data) ~= "table") then
            tInsert(self._, data)
        else
            for k, v in ipairs(data) do
                tInsert(self._, v)
            end
        end
        return self
    end
    _list.filter = function(self, func)
        local newList = List.new()
        for k, v in ipairs(self._) do
            if (func(v)) then
                newList:push(v)
            end
        end
        return newList
    end
    _list.map = function(self, func)
        local newList = List.new()
        for k, v in ipairs(self._) do
            tInsert(newList._, func(v))
        end
        return newList
    end
    _list.reduce = function(self, func)
        local result = self._[1]
        for i = 2, #self._ do
            result = func(result, self._[i])
        end
        return result
    end
    _list.foreach = function(self,func)
        for i = 1, #self._ do
            func(self._[i])
        end
    end
	_list.flatten = function(self)
		local newList = List.new()
		for k, v in ipairs(self._) do
			if (type(v) == "table") then
				local _newList = v:flatten()
				for _k, _v in ipairs(_newList) do
					tInsert(newList._, _v)
				end
			else
				tInsert(newList._, v)
			end
		end
		return newList
	end
	_list.sort = function(self)
        if (#self < 2) then
            return self
        else
            return _list.sort(self:filter( function(a) return a < self:head() end))
            + self:filter( function(a) return a == self:head() end)
            + _list.sort(self:filter( function(a) return a > self:head() end))
        end
	end

	_list.invert = function(self)
		local newList = List.new()
		for k, v in ipairs(self._) do
			tInsert(newList._, 1, v)
		end
		return newList
	end
    local metatable = { }
    metatable.__add = function(self, other)
        return List.new():push(self._):push(other._)
    end
    metatable.__tostring = function(self)
        return self:reduce( function(a, b) return tostring(a) .. "," .. tostring(b) end)
    end
    metatable.__index = function(self,index)
        return self._[index]
    end
    metatable.__len = function(self)
    -- Lua 5.1 不适用, 用self:length()
        return #self._
    end
    setmetatable(_list, metatable)

    return _list
end
List.wrap = function(t)
	local newList = List.new()
	if (not t) then
		return newList
	end
	if (type(t) ~= "table") then
		newList:push(t)
		return newList
	end
	newList._ = t
	return newList
end
return List

