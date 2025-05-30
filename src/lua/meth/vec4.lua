local meth = require("src.lua.meth")
---@class meth.Vec4
---@field x float
---@field y float
---@field z float
---@field w float
---@operator add(meth.Vec4): meth.Vec4
---@operator add(number): meth.Vec4
---@operator sub(meth.Vec4): meth.Vec4
---@operator sub(number): meth.Vec4
---@operator mul(meth.Vec4): meth.Vec4
---@operator mul(number): meth.Vec4
---@operator div(meth.Vec4): meth.Vec4
---@operator div(number): meth.Vec4
---@operator mod(meth.Vec4): meth.Vec4
---@operator mod(number): meth.Vec4
---@operator unm:meth.Vec4
---@operator pow(meth.Vec4): meth.Vec4
---@operator pow(number): meth.Vec4

---@class meth.Vec4
local methods = {
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return meth.Vec4
	assign_from = function(self, rhs)
		self[1] = rhs[1]
		self[2] = rhs[2]
		self[3] = rhs[3]
		self[4] = rhs[4]
		return self
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	copy = function(self)
		return vec4(self[1], self[2], self[3], self[4])
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@param s float
	---@return meth.Vec4
	lerped = function(self, rhs, s)
		return vec4(
			self[1] * (1.0 - s) + rhs[1] * s,
			self[2] * (1.0 - s) + rhs[2] * s,
			self[3] * (1.0 - s) + rhs[3] * s,
			self[4] * (1.0 - s) + rhs[4] * s
		)
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@param s float
	---@return meth.Vec4
	lerp = function(self, rhs, s)
		self[1] = self[1] * (1.0 - s) + rhs[1] * s
		self[2] = self[2] * (1.0 - s) + rhs[2] * s
		self[3] = self[3] * (1.0 - s) + rhs[3] * s
		self[4] = self[4] * (1.0 - s) + rhs[4] * s
		return self
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	fract_gl = function(self)
		self[1] = meth.fract_gl(self[1])
		self[2] = meth.fract_gl(self[2])
		self[3] = meth.fract_gl(self[3])
		self[4] = meth.fract_gl(self[4])
		return self
	end,
	---@return meth.Vec4
	---@param self meth.Vec4
	fract_gled = function(self)
		return vec4(meth.fract_gl(self[1]), meth.fract_gl(self[2]), meth.fract_gl(self[3]), meth.fract_gl(self[4]))
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	trunc = function(self)
		self[1] = meth.trunc(self[1])
		self[2] = meth.trunc(self[2])
		self[3] = meth.trunc(self[3])
		self[4] = meth.trunc(self[4])
		return self
	end,
	---@return meth.Vec4
	---@param self meth.Vec4
	trunced = function(self)
		return vec4(meth.trunc(self[1]), meth.trunc(self[2]), meth.trunc(self[3]), meth.trunc(self[4]))
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	fract = function(self)
		self[1] = meth.fract(self[1])
		self[2] = meth.fract(self[2])
		self[3] = meth.fract(self[3])
		self[4] = meth.fract(self[4])
		return self
	end,
	---@return meth.Vec4
	---@param self meth.Vec4
	fracted = function(self)
		return vec4(meth.fract(self[1]), meth.fract(self[2]), meth.fract(self[3]), meth.fract(self[4]))
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	round = function(self)
		self[1] = meth.round(self[1])
		self[2] = meth.round(self[2])
		self[3] = meth.round(self[3])
		self[4] = meth.round(self[4])
		return self
	end,
	---@return meth.Vec4
	---@param self meth.Vec4
	rounded = function(self)
		return vec4(meth.round(self[1]), meth.round(self[2]), meth.round(self[3]), meth.round(self[4]))
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	ceil = function(self)
		self[1] = math.ceil(self[1])
		self[2] = math.ceil(self[2])
		self[3] = math.ceil(self[3])
		self[4] = math.ceil(self[4])
		return self
	end,
	---@return meth.Vec4
	---@param self meth.Vec4
	ceiled = function(self)
		return vec4(math.ceil(self[1]), math.ceil(self[2]), math.ceil(self[3]), math.ceil(self[4]))
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	floor = function(self)
		self[1] = math.floor(self[1])
		self[2] = math.floor(self[2])
		self[3] = math.floor(self[3])
		self[4] = math.floor(self[4])
		return self
	end,
	---@return meth.Vec4
	---@param self meth.Vec4
	floored = function(self)
		return vec4(math.floor(self[1]), math.floor(self[2]), math.floor(self[3]), math.floor(self[4]))
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	normalize = function(self)
		local length = self:length()
		self[1] = self[1] / length
		self[2] = self[2] / length
		self[3] = self[3] / length
		self[4] = self[4] / length
		return self
	end,
	---@param self meth.Vec4
	---@return meth.Vec4
	normalized = function(self)
		local length = self:length()
		return vec4(self[1] / length, self[2] / length, self[3] / length, self[4] / length)
	end,
	---@param self meth.Vec4
	---@param min meth.Vec4
	---@param max meth.Vec4
	---@return meth.Vec4
	clamp = function(self, min, max)
		self[1] = meth.clamp(self[1], min[1], max[1])
		self[2] = meth.clamp(self[2], min[2], max[2])
		self[3] = meth.clamp(self[3], min[3], max[3])
		self[4] = meth.clamp(self[4], min[4], max[4])
		return self
	end,
	---@param self meth.Vec4
	---@param min meth.Vec4
	---@param max meth.Vec4
	---@return meth.Vec4
	clamped = function(self, min, max)
		return vec4(
			meth.clamp(self[1], min[1], max[1]),
			meth.clamp(self[2], min[2], max[2]),
			meth.clamp(self[3], min[3], max[3]),
			meth.clamp(self[4], min[4], max[4])
		)
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return meth.Vec4
	min = function(self, rhs)
		self[1] = math.min(self[1], rhs[1])
		self[2] = math.min(self[2], rhs[2])
		self[3] = math.min(self[3], rhs[3])
		self[4] = math.min(self[4], rhs[4])
		return self
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return meth.Vec4
	mined = function(self, rhs)
		return vec4(
			math.min(self[1], rhs[1]),
			math.min(self[2], rhs[2]),
			math.min(self[3], rhs[3]),
			math.min(self[4], rhs[4])
		)
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return meth.Vec4
	max = function(self, rhs)
		self[1] = math.max(self[1], rhs[1])
		self[2] = math.max(self[2], rhs[2])
		self[3] = math.max(self[3], rhs[3])
		self[4] = math.max(self[4], rhs[4])
		return self
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return meth.Vec4
	maxed = function(self, rhs)
		return vec4(
			math.max(self[1], rhs[1]),
			math.max(self[2], rhs[2]),
			math.max(self[3], rhs[3]),
			math.max(self[4], rhs[4])
		)
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return meth.Vec4
	midpoint = function(self, rhs)
		self[1] = (self[1] + rhs[1]) * 0.5
		self[2] = (self[2] + rhs[2]) * 0.5
		self[3] = (self[3] + rhs[3]) * 0.5
		self[4] = (self[4] + rhs[4]) * 0.5
		return self
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return meth.Vec4
	midpointed = function(self, rhs)
		return vec4(
			(self[1] + rhs[1]) * 0.5,
			(self[2] + rhs[2]) * 0.5,
			(self[3] + rhs[3]) * 0.5,
			(self[4] + rhs[4]) * 0.5
		)
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@param d float
	---@return meth.Vec4
	move_towardsed = function(self, rhs, d)
		local a_x = rhs[1] - self[1]
		local a_y = rhs[2] - self[2]
		local a_z = rhs[3] - self[3]
		local a_w = rhs[4] - self[4]
		local len = math.sqrt(a_x * a_x + a_y * a_y + a_z * a_z + a_w * a_w)
		if len <= d or len <= 0.0001 then
			return rhs:copy()
		end
		return vec4(self[1] + a_x / len * d, self[2] + a_y / len * d, self[3] + a_z / len * d, self[4] + a_w / len * d)
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@param d float
	---@return meth.Vec4
	move_towards = function(self, rhs, d)
		local a_x = rhs[1] - self[1]
		local a_y = rhs[2] - self[2]
		local a_z = rhs[3] - self[3]
		local a_w = rhs[4] - self[4]
		local len = math.sqrt(a_x * a_x + a_y * a_y + a_z * a_z + a_w * a_w)
		if len <= d or len <= 0.0001 then
			self:assign_from(rhs)
			return self
		end
		self[1] = self[1] + a_x / len * d
		self[2] = self[2] + a_y / len * d
		self[3] = self[3] + a_z / len * d
		self[4] = self[4] + a_w / len * d
		return self
	end,
	---@param self meth.Vec4
	---@param rhs meth.Vec4
	---@return number
	dot = function(self, rhs)
		return self[1] * rhs[1] + self[2] * rhs[2] + self[3] * rhs[3] + self[4] * rhs[4]
	end,
	---@param self meth.Vec4
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w)
	end,
	---@param self meth.Vec4
	---@param value number|meth.Vec4
	---@return meth.Vec4
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
		return self
	end,
	---@param self meth.Vec4
	---@param value number|meth.Vec4
	---@return meth.Vec4
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
		return self
	end,
	---@param self meth.Vec4
	---@param value number|meth.Vec4
	---@return meth.Vec4
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
		return self
	end,
	---@param self meth.Vec4
	---@param value number|meth.Vec4
	---@return meth.Vec4
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
		return self
	end,
	---@param self meth.Vec4
	---@param value number|meth.Vec4
	---@return meth.Vec4
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
		return self
	end,
	---@param self meth.Vec4
	---@param value number|meth.Vec4
	---@return meth.Vec4
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
		return self
	end,
	---@param self meth.IVec4
	neg = function(self)
		self[1] = -self[1]
		self[2] = -self[2]
		self[3] = -self[3]
		self[4] = -self[4]
	end,
	type = "Vec4",
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
	---@param self meth.Vec4
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

---@return meth.Vec4
---@overload fun(x: number, y: number, z: number, w: number): meth.Vec4
---@overload fun(value: number): meth.Vec4
---@overload fun(): meth.Vec4
---@diagnostic disable-next-line: lowercase-global
function vec4(x, y, z, w)
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
inner.vec4_metatable = metatable
