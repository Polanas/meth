local meth = require("src.lua.meth")
---@class meth.IVec4
---@field x integer
---@field y integer
---@field z integer
---@field w integer
---@operator add(meth.IVec4): meth.IVec4
---@operator add(number): meth.IVec4
---@operator sub(meth.IVec4): meth.IVec4
---@operator sub(number): meth.IVec4
---@operator mul(meth.IVec4): meth.IVec4
---@operator mul(number): meth.IVec4
---@operator div(meth.IVec4): meth.IVec4
---@operator div(number): meth.IVec4
---@operator mod(meth.IVec4): meth.IVec4
---@operator mod(number): meth.IVec4
---@operator unm:meth.IVec4
---@operator pow(meth.IVec4): meth.IVec4
---@operator pow(number): meth.IVec4

---@class meth.IVec4
local methods = {
	---@param self meth.IVec4
	---@return meth.Vec4
	as_vec3 = function(self)
		return vec4(self[1], self[2], self[3], self[4])
	end,
	---@param self meth.IVec4
	---@return integer, integer, integer, integer
	unpack = function(self)
		return self[1], self[2], self[3], self[4]
	end,
	---@param self meth.IVec4
	---@param min meth.IVec4
	---@param max meth.IVec4
	---@return meth.IVec4
	clamp = function(self, min, max)
		self[1] = meth.clamp(self[1], min[1], max[1])
		self[2] = meth.clamp(self[2], min[2], max[2])
		self[3] = meth.clamp(self[3], min[3], max[3])
		self[4] = meth.clamp(self[4], min[4], max[4])
		return self
	end,
	---@param self meth.IVec4
	---@param min meth.IVec4
	---@param max meth.IVec4
	---@return meth.IVec4
	clamped = function(self, min, max)
		return ivec4(
			meth.clamp(self[1], min[1], max[1]),
			meth.clamp(self[2], min[2], max[2]),
			meth.clamp(self[3], min[3], max[3]),
			meth.clamp(self[4], min[4], max[4])
		)
	end,
	---@param self meth.IVec4
	---@param rhs meth.IVec4
	---@return meth.IVec4
	min = function(self, rhs)
		self[1] = math.min(self[1], rhs[1])
		self[2] = math.min(self[2], rhs[2])
		self[3] = math.min(self[3], rhs[3])
		self[4] = math.min(self[4], rhs[4])
		return self
	end,
	---@param self meth.IVec4
	---@param rhs meth.IVec4
	---@return meth.IVec4
	mined = function(self, rhs)
		return ivec4(
			math.min(self[1], rhs[1]),
			math.min(self[2], rhs[2]),
			math.min(self[3], rhs[3]),
			math.min(self[4], rhs[4])
		)
	end,
	---@param self meth.IVec4
	---@param rhs meth.IVec4
	---@return meth.IVec4
	max = function(self, rhs)
		self[1] = math.max(self[1], rhs[1])
		self[2] = math.max(self[2], rhs[2])
		self[3] = math.max(self[3], rhs[3])
		self[4] = math.max(self[4], rhs[4])
		return self
	end,
	---@param self meth.IVec4
	---@param rhs meth.IVec4
	---@return meth.IVec4
	maxed = function(self, rhs)
		return ivec4(
			math.max(self[1], rhs[1]),
			math.max(self[2], rhs[2]),
			math.max(self[3], rhs[3]),
			math.max(self[4], rhs[4])
		)
	end,
	---@param self meth.IVec4
	---@param rhs meth.IVec4
	---@return meth.IVec4
	assign_from = function(self, rhs)
		self[1] = rhs[1]
		self[2] = rhs[2]
		self[3] = rhs[3]
		self[4] = rhs[4]
		return self
	end,
	---@param self meth.IVec4
	---@return meth.IVec4
	copy = function(self)
		return ivec4(self[1], self[2], self[3], self[4])
	end,
	---@param self meth.IVec4
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w)
	end,
	---@param self meth.IVec4
	---@param value number|meth.IVec4
	add = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] + value
			self[2] = self[2] + value
			self[3] = self[3] + value
			self[4] = self[4] + value
		else
			self[1] = self[1] + value[1]
			self[2] = self[2] + value[2]
			self[3] = self[3] + value[3]
			self[4] = self[4] + value[4]
		end
	end,
	---@param self meth.IVec4
	---@param value number|meth.IVec4
	sub = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] - value
			self[2] = self[2] - value
			self[3] = self[3] - value
			self[4] = self[4] - value
		else
			self[1] = self[1] - value[1]
			self[2] = self[2] - value[2]
			self[3] = self[3] - value[3]
			self[4] = self[4] - value[4]
		end
	end,
	---@param self meth.IVec4
	---@param value number|meth.IVec4
	div = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] / value
			self[2] = self[2] / value
			self[3] = self[3] / value
			self[4] = self[4] / value
		else
			self[1] = self[1] / value[1]
			self[2] = self[2] / value[2]
			self[3] = self[3] / value[3]
			self[4] = self[4] / value[4]
		end
	end,
	---@param self meth.IVec4
	---@param value number|meth.IVec4
	mul = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] * value
			self[2] = self[2] * value
			self[3] = self[3] * value
			self[4] = self[4] * value
		else
			self[1] = self[1] * value[1]
			self[2] = self[2] * value[2]
			self[3] = self[3] * value[3]
			self[4] = self[4] * value[4]
		end
	end,
	---@param self meth.IVec4
	---@param value number|meth.IVec4
	mod = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] % value
			self[2] = self[2] % value
			self[3] = self[3] % value
			self[4] = self[4] % value
		else
			self[1] = self[1] % value[1]
			self[2] = self[2] % value[2]
			self[3] = self[3] % value[3]
			self[4] = self[4] % value[4]
		end
	end,
	---@param self meth.IVec4
	---@param value number|meth.IVec4
	pow = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] ^ value
			self[2] = self[2] ^ value
			self[3] = self[3] ^ value
			self[4] = self[4] ^ value
		else
			self[1] = self[1] ^ value[1]
			self[2] = self[2] ^ value[2]
			self[3] = self[3] ^ value[3]
			self[4] = self[4] ^ value[4]
		end
	end,
	---@param self meth.IVec4
	neg = function(self)
		self[1] = -self[1]
		self[2] = -self[2]
		self[3] = -self[3]
		self[4] = -self[4]
	end,
	type = "IVec4",
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
	__add = function(a, b)
		if type(a) == "number" then
			return vec4(a + b[1], a + b[2], a + b[3], a + b[4])
		elseif type(b) == "number" then
			return vec4(a[1] + b, a[2] + b, a[3] + b, a[4] + b)
		else
			return vec4(a[1] + b[1], a[2] + b[2], a[3] + b[3], a[4] + b[4])
		end
	end,
	__sub = function(a, b)
		if type(a) == "number" then
			return vec4(a - b[1], a - b[2], a - b[3], a - b[4])
		elseif type(b) == "number" then
			return vec4(a[1] - b, a[2] - b, a[3] - b, a[4] - b)
		else
			return vec4(a[1] - b[1], a[2] - b[2], a[3] - b[3], a[4] - b[4])
		end
	end,

	__mul = function(a, b)
		if type(a) == "number" then
			return vec4(a * b[1], a * b[2], a * b[3], a * b[4])
		elseif type(b) == "number" then
			return vec4(a[1] * b, a[2] * b, a[3] * b, a[4] * b)
		else
			return vec4(a[1] * b[1], a[2] * b[2], a[3] * b[3], a[4] * b[4])
		end
	end,
	__div = function(a, b)
		if type(a) == "number" then
			return vec4(a / b[1], a / b[2], a / b[3], a / b[4])
		elseif type(b) == "number" then
			return vec4(a[1] / b, a[2] / b, a[3] / b, a[4] / b)
		else
			return vec4(a[1] / b[1], a[2] / b[2], a[3] / b[3], a[4] / b[4])
		end
	end,
	__mod = function(a, b)
		if type(a) == "number" then
			return vec4(a % b[1], a % b[2], a % b[3], a % b[4])
		elseif type(b) == "number" then
			return vec4(a[1] % b, a[2] % b, a[3] % b, a[4] % b)
		else
			return vec4(a[1] % b[1], a[2] % b[2], a[3] % b[3], a[4] % b[4])
		end
	end,
	__pow = function(a, b)
		if type(a) == "number" then
			return vec4(a ^ b[1], a ^ b[2], a ^ b[3], a ^ b[4])
		elseif type(b) == "number" then
			return vec4(a[1] ^ b, a[2] ^ b, a[3] ^ b, a[4] ^ b)
		else
			return vec4(a[1] ^ b[1], a[2] ^ b[2], a[3] ^ b[3], a[4] ^ b[4])
		end
	end,
	__unm = function(a)
		return vec4(-a[1], -a[2], -a[3], -a[4])
	end,
	__eq = function(a, b)
		return a[1] == b[1] and a[2] == b[2] and a[3] == b[3] and a[4] == b[4]
	end,
	__len = function()
		return 4
	end,
	__tostring = function(self)
		return "(" .. self[1] .. ", " .. self[2] .. ", " .. self[3] .. ", " .. self[4] .. ")"
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

local inner = _G["__inner"]
---@type __inner
local inner = inner ~= nil and inner or {}
_G["__inner"] = inner
inner.meth.ivec4_metatable = metatable
