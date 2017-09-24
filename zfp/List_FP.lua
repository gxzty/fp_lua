local List = { }
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
            table.insert(self._, data)
        else
            for k, v in ipairs(data) do
                table.insert(self._, v)
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
            table.insert(newList._, func(v))
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
					table.insert(newList._, _v)
				end
			else
				table.insert(newList._, v)
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
return List


--    local List = require("List_FP")
--    local new1 = List.new(1, 3, 4, 5):map( function(a) return a * 2 end)
--    local new2 = List.new(1, 9, 7, 3, 4, 5)
--    local qSort
--    qSort = function(list)
--        if (list:length() < 2) then
--            return list
--        else
--            return qSort(list:filter( function(a) return a < list:head() end))
--            + list:filter( function(a) return a == list:head() end)
--            + qSort(list:filter( function(a) return a > list:head() end))
--        end
--    end
--    local new3 = qSort(new1 + new2)
--    local new4 = new3:reduce( function(a, b) return a + b end)
--    print("====new1 map====")
--    new1:toString()
--    print("====new2 foreach====")
--    new2:foreach(print)
--    print("====new3 qSort====")
--    new3:toString()
--    print("====new4 reduce====")
--    print(new4)
