---@class meth.Vec3
---@field x float
---@field y float
---@field z float
---@operator add(meth.Vec3): meth.Vec3
---@operator add(number): meth.Vec3
---@operator sub(meth.Vec3): meth.Vec3
---@operator sub(number): meth.Vec3
---@operator mul(meth.Vec3): meth.Vec3
---@operator mul(number): meth.Vec3
---@operator div(meth.Vec3): meth.Vec3
---@operator div(number): meth.Vec3
---@operator mod(meth.Vec3): meth.Vec3
---@operator mod(number): meth.Vec3
---@operator unm:meth.Vec3
---@operator pow(meth.Vec3): meth.Vec3
---@operator pow(number): meth.Vec3

---@class meth.Vec3
local methods = {
	---@param self meth.Vec3
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	add = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] + value
			self[2] = self[2] + value
			self[3] = self[3] + value
		else
			self[1] = self[1] + value[1]
			self[2] = self[2] + value[2]
			self[3] = self[3] + value[3]
		end
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	sub = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] - value
			self[2] = self[2] - value
			self[3] = self[3] - value
		else
			self[1] = self[1] - value[1]
			self[2] = self[2] - value[2]
			self[3] = self[3] - value[3]
		end
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	div = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] / value
			self[2] = self[2] / value
			self[3] = self[3] / value
		else
			self[1] = self[1] / value[1]
			self[2] = self[2] / value[2]
			self[3] = self[3] / value[3]
		end
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	mul = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] * value
			self[2] = self[2] * value
			self[3] = self[3] * value
		else
			self[1] = self[1] * value[1]
			self[2] = self[2] * value[2]
			self[3] = self[3] * value[3]
		end
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	mod = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] % value
			self[2] = self[2] % value
			self[3] = self[3] % value
		else
			self[1] = self[1] % value[1]
			self[2] = self[2] % value[2]
			self[3] = self[3] % value[3]
		end
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	pow = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] ^ value
			self[2] = self[2] ^ value
			self[3] = self[3] ^ value
		else
			self[1] = self[1] ^ value[1]
			self[2] = self[2] ^ value[2]
			self[3] = self[3] ^ value[3]
		end
	end,
	---@param self meth.IVec3
	neg = function(self)
		self[1] = -self[1]
		self[2] = -self[2]
		self[3] = -self[3]
	end,
	type = "Vec3",
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
	__add = function(a, b)
		if type(a) == "number" then
			return vec3(a + b[1], a + b[2], a + b[3])
		elseif type(b) == "number" then
			return vec3(a[1] + b, a[2] + b, a[3] + b)
		else
			return vec3(a[1] + b[1], a[2] + b[2], a[3] + b[3])
		end
	end,
	__sub = function(a, b)
		if type(a) == "number" then
			return vec3(a - b[1], a - b[2], a - b[3])
		elseif type(b) == "number" then
			return vec3(a[1] - b, a[2] - b, a[3] - b)
		else
			return vec3(a[1] - b[1], a[2] - b[2], a[3] - b[3])
		end
	end,

	__mul = function(a, b)
		if type(a) == "number" then
			return vec3(a * b[1], a * b[2], a * b[3])
		elseif type(b) == "number" then
			return vec3(a[1] * b, a[2] * b, a[3] * b)
		else
			return vec3(a[1] * b[1], a[2] * b[2], a[3] * b[3])
		end
	end,
	__div = function(a, b)
		if type(a) == "number" then
			return vec3(a / b[1], a / b[2], a / b[3])
		elseif type(b) == "number" then
			return vec3(a[1] / b, a[2] / b, a[3] / b)
		else
			return vec3(a[1] / b[1], a[2] / b[2], a[3] / b[3])
		end
	end,
	__mod = function(a, b)
		if type(a) == "number" then
			return vec3(a % b[1], a % b[2], a % b[3])
		elseif type(b) == "number" then
			return vec3(a[1] % b, a[2] % b, a[3] % b)
		else
			return vec3(a[1] % b[1], a[2] % b[2], a[3] % b[3])
		end
	end,
	__pow = function(a, b)
		if type(a) == "number" then
			return vec3(a ^ b[1], a ^ b[2], a ^ b[3])
		elseif type(b) == "number" then
			return vec3(a[1] ^ b, a[2] ^ b, a[3] ^ b)
		else
			return vec3(a[1] ^ b[1], a[2] ^ b[2], a[3] ^ b[3])
		end
	end,
	__unm = function(a)
		return vec3(-a[1], -a[2], -a[3])
	end,
	__eq = function(a, b)
		return a[1] == b[1] and a[2] == b[2] and a[3] == b[3]
	end,
	__len = function()
		return 3
	end,
	__tostring = function(self)
		return "(" .. self[1] .. ", " .. self[2] .. ", " .. self[3] .. ")"
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

local inner = _G["__inner"]
---@type __inner
local inner = inner ~= nil and inner or {}
_G["__inner"] = inner
inner.vec3_metatable = metatable
