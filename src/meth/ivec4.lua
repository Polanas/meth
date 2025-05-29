---@class meth.IVec4
---@field x integer
---@field y integer
---@field z integer
---@field w integer

---@class meth.IVec4
local methods = {
	---@param self meth.IVec4
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w)
	end,
}

---@type metatable
local metatable = {
	__newindex = function(self, key, value)
		if key == "x" then
			self[1] = value
		elseif key == "y" then
			self[2] = value
		elseif key == "z" then
			self[3] = value
		elseif key == "w" then
			self[4] = value
		end
	end,
	---@param self meth.IVec4
	__index = function(self, value)
		if value == "x" then
			return self[1]
		elseif value == "y" then
			return self[2]
		elseif value == "z" then
			return self[3]
		elseif value == "w" then
			return self[4]
		else
			return methods[value]
		end
	end,
}

---@return meth.IVec4
---@overload fun(x: integer, y: integer, z: integer, w: integer): meth.IVec4
---@overload fun(value: integer): meth.IVec4
---@overload fun(): meth.IVec4
---@diagnostic disable-next-line: lowercase-global
function ivec4(x, y, z, w)
	if not x then
		return setmetatable({ 0, 0, 0, 0 }, metatable)
	elseif x and not y and not z then
		return setmetatable({ x, x, x, x }, metatable)
	else
		return setmetatable({ x, y, z, w }, metatable)
	end
end

---@diagnostic disable-next-line: undefined-global
local inner = __inner ~= nil and __inner or {}
---@diagnostic disable-next-line: undefined-global
__inner = inner
inner.ivec4_metatable = metatable
