---@class meth.Vec3
---@field x float
---@field y float
---@field z float

---@class meth.Vec3
local methods = {
	---@param self meth.Vec3
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
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
		end
	end,
	---@param self meth.Vec3
	__index = function(self, value)
		if value == "x" then
			return self[1]
		elseif value == "y" then
			return self[2]
		elseif value == "z" then
			return self[3]
		else
			return methods[value]
		end
	end,
}

---@return meth.Vec3
---@overload fun(x: number, y: number, z: number): meth.Vec3
---@overload fun(value: number): meth.Vec3
---@overload fun(): meth.Vec3
---@diagnostic disable-next-line: lowercase-global
function vec3(x, y, z)
	if not x then
		return setmetatable({ 0, 0, 0 }, metatable)
	elseif x and not y and not z then
		return setmetatable({ x, x, x }, metatable)
	else
		return setmetatable({ x, y, z }, metatable)
	end
end

---@diagnostic disable-next-line: undefined-global
local inner = __inner ~= nil and __inner or {}
---@diagnostic disable-next-line: undefined-global
__inner = inner
inner.vec3_metatable = metatable
