local meth = require("src.lua.meth")

---@class meth.IVec2
---@field x integer
---@field y integer
---@operator add(meth.IVec2): meth.IVec2
---@operator add(number): meth.IVec2
---@operator sub(meth.IVec2): meth.IVec2
---@operator sub(number): meth.IVec2
---@operator mul(meth.IVec2): meth.IVec2
---@operator mul(number): meth.IVec2
---@operator div(meth.IVec2): meth.IVec2
---@operator div(number): meth.IVec2
---@operator mod(meth.IVec2): meth.IVec2
---@operator mod(number): meth.IVec2
---@operator unm:meth.IVec2
---@operator pow(meth.IVec2): meth.IVec2
---@operator pow(number): meth.IVec2

---@class meth.IVec2
local methods = {
	clamp = function(self, min, max)
		self[1] = meth.clamp(self[1], min[1], max[1])
		self[2] = meth.clamp(self[2], min[2], max[2])
		return self
	end,
	---@param self meth.IVec2
	---@param min meth.IVec2
	---@param max meth.IVec2
	---@return meth.IVec2
	clamped = function(self, min, max)
		return ivec2(meth.clamp(self[1], min[1], max[1]), meth.clamp(self[2], min[2], max[2]))
	end,
	---@param self meth.IVec2
	---@param rhs meth.IVec2
	---@return meth.IVec2
	min = function(self, rhs)
		self[1] = math.min(self[1], rhs[1])
		self[2] = math.min(self[2], rhs[2])
		return self
	end,
	---@param self meth.IVec2
	---@param rhs meth.IVec2
	---@return meth.IVec2
	mined = function(self, rhs)
		return ivec2(math.min(self[1], rhs[1]), math.min(self[2], rhs[2]))
	end,
	---@param self meth.IVec2
	---@param rhs meth.IVec2
	---@return meth.IVec2
	max = function(self, rhs)
		self[1] = math.max(self[1], rhs[1])
		self[2] = math.max(self[2], rhs[2])
		return self
	end,
	---@param self meth.IVec2
	---@param rhs meth.IVec2
	---@return meth.IVec2
	maxed = function(self, rhs)
		return ivec2(math.max(self[1], rhs[1]), math.max(self[2], rhs[2]))
	end,
	---@param self meth.IVec2
	---@param rhs meth.IVec2
	---@return meth.IVec2
	assign_from = function(self, rhs)
		self[1] = rhs[1]
		self[2] = rhs[2]
		return self
	end,
	---@param self meth.IVec2
	---@return meth.IVec2
	copy = function(self)
		return ivec2(self[1], self[2])
	end,
	---@param self meth.IVec2
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y)
	end,
	---@param self meth.IVec2
	---@param value number|meth.IVec2
	add = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] + value
			self[2] = self[2] + value
		else
			self[1] = self[1] + value[1]
			self[2] = self[2] + value[2]
		end
	end,
	---@param self meth.IVec2
	---@param value number|meth.IVec2
	sub = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] - value
			self[2] = self[2] - value
		else
			self[1] = self[1] - value[1]
			self[2] = self[2] - value[2]
		end
	end,
	---@param self meth.IVec2
	---@param value number|meth.IVec2
	div = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] / value
			self[2] = self[2] / value
		else
			self[1] = self[1] / value[1]
			self[2] = self[2] / value[2]
		end
	end,
	---@param self meth.IVec2
	---@param value number|meth.IVec2
	mul = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] * value
			self[2] = self[2] * value
		else
			self[1] = self[1] * value[1]
			self[2] = self[2] * value[2]
		end
	end,
	---@param self meth.IVec2
	---@param value number|meth.IVec2
	mod = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] % value
			self[2] = self[2] % value
		else
			self[1] = self[1] % value[1]
			self[2] = self[2] % value[2]
		end
	end,
	---@param self meth.IVec2
	---@param value number|meth.IVec2
	pow = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] ^ value
			self[2] = self[2] ^ value
		else
			self[1] = self[1] ^ value[1]
			self[2] = self[2] ^ value[2]
		end
	end,
	---@param self meth.IVec2
	neg = function(self)
		self[1] = -self[1]
		self[2] = -self[2]
	end,
	type = "IVec2",
}
---@type metatable
local metatable = {
	__newindex = function(self, key, value)
		if key == "x" then
			self[1] = value
		elseif key == "y" then
			self[2] = value
		end
	end,
	---@param self meth.IVec2
	__index = function(self, value)
		if value == "x" then
			return self[1]
		elseif value == "y" then
			return self[2]
		else
			return methods[value]
		end
	end,
	__add = function(a, b)
		if type(a) == "number" then
			return ivec2(a + b[1], a + b[2])
		elseif type(b) == "number" then
			return ivec2(a[1] + b, a[2] + b)
		else
			return ivec2(a[1] + b[1], a[2] + b[2])
		end
	end,
	__sub = function(a, b)
		if type(a) == "number" then
			return ivec2(a - b[1], a - b[2])
		elseif type(b) == "number" then
			return ivec2(a[1] - b, a[2] - b)
		else
			return ivec2(a[1] - b[1], a[2] - b[2])
		end
	end,

	__mul = function(a, b)
		if type(a) == "number" then
			return ivec2(a * b[1], a * b[2])
		elseif type(b) == "number" then
			return ivec2(a[1] * b, a[2] * b)
		else
			return ivec2(a[1] * b[1], a[2] * b[2])
		end
	end,
	__div = function(a, b)
		if type(a) == "number" then
			return ivec2(a / b[1], a / b[2])
		elseif type(b) == "number" then
			return ivec2(a[1] / b, a[2] / b)
		else
			return ivec2(a[1] / b[1], a[2] / b[2])
		end
	end,

	__mod = function(a, b)
		if type(a) == "number" then
			return ivec2(a % b[1], a % b[2])
		elseif type(b) == "number" then
			return ivec2(a[1] % b, a[2] % b)
		else
			return ivec2(a[1] % b[1], a[2] % b[2])
		end
	end,
	__unm = function(a)
		return ivec2(-a[1], -a[2])
	end,
	__pow = function(a, b)
		if type(a) == "number" then
			return ivec2(a ^ b[1], a ^ b[2])
		elseif type(b) == "number" then
			return ivec2(a[1] ^ b, a[2] ^ b)
		else
			return ivec2(a[1] ^ b[1], a[2] ^ b[2])
		end
	end,
	__eq = function(a, b)
		return a[1] == b[1] and a[2] == b[2]
	end,
	__len = function()
		return 2
	end,
	__tostring = function(self)
		return "(" .. self[1] .. ", " .. self[2] .. ")"
	end,
}

---@return meth.IVec2
---@overload fun(x: number, y: number): meth.IVec2
---@overload fun(value: number): meth.IVec2
---@overload fun(): meth.IVec2
---@diagnostic disable-next-line: lowercase-global
function ivec2(x, y)
	if not x then
		return setmetatable({ 0, 0 }, metatable)
	elseif x and not y then
		return setmetatable({ x, x }, metatable)
	else
		return setmetatable({ x, y }, metatable)
	end
end

local inner = _G["__inner"]
---@type __inner
local inner = inner ~= nil and inner or {}
_G["__inner"] = inner
inner.ivec2_metatable = metatable
