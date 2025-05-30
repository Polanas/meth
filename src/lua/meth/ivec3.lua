local meth = require("src.lua.meth")
---@class meth.IVec3
---@field x float
---@field y float
---@field z float
---@operator add(meth.IVec3): meth.IVec3
---@operator add(number): meth.IVec3
---@operator sub(meth.IVec3): meth.IVec3
---@operator sub(number): meth.IVec3
---@operator mul(meth.IVec3): meth.IVec3
---@operator mul(number): meth.IVec3
---@operator div(meth.IVec3): meth.IVec3
---@operator div(number): meth.IVec3
---@operator mod(meth.IVec3): meth.IVec3
---@operator mod(number): meth.IVec3
---@operator unm:meth.IVec3
---@operator pow(meth.IVec3): meth.IVec3
---@operator pow(number): meth.IVec3

---@class meth.IVec3
local methods = {
	---@param self meth.IVec3
	---@param min meth.IVec3
	---@param max meth.IVec3
	---@return meth.IVec3
	clamp = function(self, min, max)
		self[1] = meth.clamp(self[1], min[1], max[1])
		self[2] = meth.clamp(self[2], min[2], max[2])
		self[3] = meth.clamp(self[3], min[3], max[3])
		return self
	end,
	---@param self meth.IVec3
	---@param min meth.IVec3
	---@param max meth.IVec3
	---@return meth.IVec3
	clamped = function(self, min, max)
		return ivec3(
			meth.clamp(self[1], min[1], max[1]),
			meth.clamp(self[2], min[2], max[2]),
			meth.clamp(self[3], min[3], max[3])
		)
	end,
	---@param self meth.IVec3
	---@param rhs meth.IVec3
	---@return meth.IVec3
	min = function(self, rhs)
		self[1] = math.min(self[1], rhs[1])
		self[2] = math.min(self[2], rhs[2])
		self[3] = math.min(self[3], rhs[3])
		return self
	end,
	---@param self meth.IVec3
	---@param rhs meth.IVec3
	---@return meth.IVec3
	mined = function(self, rhs)
		return ivec3(math.min(self[1], rhs[1]), math.min(self[2], rhs[2]), math.min(self[3], rhs[3]))
	end,
	---@param self meth.IVec3
	---@param rhs meth.IVec3
	---@return meth.IVec3
	max = function(self, rhs)
		self[1] = math.max(self[1], rhs[1])
		self[2] = math.max(self[2], rhs[2])
		self[3] = math.max(self[3], rhs[3])
		return self
	end,
	---@param self meth.IVec3
	---@param rhs meth.IVec3
	---@return meth.IVec3
	maxed = function(self, rhs)
		return ivec3(math.max(self[1], rhs[1]), math.max(self[2], rhs[2]), math.max(self[3], rhs[3]))
	end,
	---@param self meth.IVec3
	---@param rhs meth.IVec3
	---@return meth.IVec3
	assign_from = function(self, rhs)
		self[1] = rhs[1]
		self[2] = rhs[2]
		self[3] = rhs[3]
		return self
	end,
	---@param self meth.IVec3
	---@return meth.IVec3
	copy = function(self)
		return ivec3(self[1], self[2], self[3])
	end,
	---@param self meth.IVec3
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
	end,
	---@param self meth.IVec3
	---@param value number|meth.IVec3
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
	---@param self meth.IVec3
	---@param value number|meth.IVec3
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
	---@param self meth.IVec3
	---@param value number|meth.IVec3
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
	---@param self meth.IVec3
	---@param value number|meth.IVec3
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
	---@param self meth.IVec3
	---@param value number|meth.IVec3
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
	---@param self meth.IVec3
	---@param value number|meth.IVec3
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
	type = "IVec3",
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
	---@param self meth.IVec3
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
			return ivec3(a + b[1], a + b[2], a + b[3])
		elseif type(b) == "number" then
			return ivec3(a[1] + b, a[2] + b, a[3] + b)
		else
			return ivec3(a[1] + b[1], a[2] + b[2], a[3] + b[3])
		end
	end,
	__sub = function(a, b)
		if type(a) == "number" then
			return ivec3(a - b[1], a - b[2], a - b[3])
		elseif type(b) == "number" then
			return ivec3(a[1] - b, a[2] - b, a[3] - b)
		else
			return ivec3(a[1] - b[1], a[2] - b[2], a[3] - b[3])
		end
	end,

	__mul = function(a, b)
		if type(a) == "number" then
			return ivec3(a * b[1], a * b[2], a * b[3])
		elseif type(b) == "number" then
			return ivec3(a[1] * b, a[2] * b, a[3] * b)
		else
			return ivec3(a[1] * b[1], a[2] * b[2], a[3] * b[3])
		end
	end,
	__div = function(a, b)
		if type(a) == "number" then
			return ivec3(a / b[1], a / b[2], a / b[3])
		elseif type(b) == "number" then
			return ivec3(a[1] / b, a[2] / b, a[3] / b)
		else
			return ivec3(a[1] / b[1], a[2] / b[2], a[3] / b[3])
		end
	end,
	__mod = function(a, b)
		if type(a) == "number" then
			return ivec3(a % b[1], a % b[2], a % b[3])
		elseif type(b) == "number" then
			return ivec3(a[1] % b, a[2] % b, a[3] % b)
		else
			return ivec3(a[1] % b[1], a[2] % b[2], a[3] % b[3])
		end
	end,
	__pow = function(a, b)
		if type(a) == "number" then
			return ivec3(a ^ b[1], a ^ b[2], a ^ b[3])
		elseif type(b) == "number" then
			return ivec3(a[1] ^ b, a[2] ^ b, a[3] ^ b)
		else
			return ivec3(a[1] ^ b[1], a[2] ^ b[2], a[3] ^ b[3])
		end
	end,
	__unm = function(a)
		return ivec3(-a[1], -a[2], -a[3])
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

---@return meth.IVec3
---@overload fun(x: number, y: number, z: number): meth.IVec3
---@overload fun(value: number): meth.IVec3
---@overload fun(): meth.IVec3
---@diagnostic disable-next-line: lowercase-global
function ivec3(x, y, z)
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
inner.ivec3_metatable = metatable
