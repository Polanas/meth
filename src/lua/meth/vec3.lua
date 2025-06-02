local meth = require("src.lua.meth")
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
	---@return meth.IVec3
	as_ivec3 = function(self)
		return ivec3(math.floor(self[1]), math.floor(self[2]), math.floor(self[3]))
	end,
	---@param self meth.Vec3
	---@return number, number, number
	unpack = function(self)
		return self[1], self[2], self[3]
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return meth.Vec3
	assign_from = function(self, rhs)
		self[1] = rhs[1]
		self[2] = rhs[2]
		self[3] = rhs[3]
		return self
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	copy = function(self)
		return vec3(self[1], self[2], self[3])
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@param s float
	---@return meth.Vec3
	lerped = function(self, rhs, s)
		return vec3(
			self[1] * (1.0 - s) + rhs[1] * s,
			self[2] * (1.0 - s) + rhs[2] * s,
			self[3] * (1.0 - s) + rhs[3] * s
		)
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@param s float
	---@return meth.Vec3
	lerp = function(self, rhs, s)
		self[1] = self[1] * (1.0 - s) + rhs[1] * s
		self[2] = self[2] * (1.0 - s) + rhs[2] * s
		self[3] = self[3] * (1.0 - s) + rhs[3] * s
		return self
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	fract_gl = function(self)
		self[1] = meth.fract_gl(self[1])
		self[2] = meth.fract_gl(self[2])
		self[3] = meth.fract_gl(self[3])
		return self
	end,
	---@return meth.Vec3
	---@param self meth.Vec3
	fract_gled = function(self)
		return vec3(meth.fract_gl(self[1]), meth.fract_gl(self[2]), meth.fract_gl(self[3]))
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	trunc = function(self)
		self[1] = meth.trunc(self[1])
		self[2] = meth.trunc(self[2])
		self[3] = meth.trunc(self[3])
		return self
	end,
	---@return meth.Vec3
	---@param self meth.Vec3
	trunced = function(self)
		return vec3(meth.trunc(self[1]), meth.trunc(self[2]), meth.trunc(self[3]))
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	fract = function(self)
		self[1] = meth.fract(self[1])
		self[2] = meth.fract(self[2])
		self[3] = meth.fract(self[3])
		return self
	end,
	---@return meth.Vec3
	---@param self meth.Vec3
	fracted = function(self)
		return vec3(meth.fract(self[1]), meth.fract(self[2]), meth.fract(self[3]))
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	round = function(self)
		self[1] = meth.round(self[1])
		self[2] = meth.round(self[2])
		self[3] = meth.round(self[3])
		return self
	end,
	---@return meth.Vec3
	---@param self meth.Vec3
	rounded = function(self)
		return vec3(meth.round(self[1]), meth.round(self[2]), meth.round(self[3]))
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	ceil = function(self)
		self[1] = math.ceil(self[1])
		self[2] = math.ceil(self[2])
		self[3] = math.ceil(self[3])
		return self
	end,
	---@return meth.Vec3
	---@param self meth.Vec3
	ceiled = function(self)
		return vec3(math.ceil(self[1]), math.ceil(self[2]), math.ceil(self[3]))
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	floor = function(self)
		self[1] = math.floor(self[1])
		self[2] = math.floor(self[2])
		self[3] = math.floor(self[3])
		return self
	end,
	---@return meth.Vec3
	---@param self meth.Vec3
	floored = function(self)
		return vec3(math.floor(self[1]), math.floor(self[2]), math.floor(self[3]))
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	normalize = function(self)
		local length = self:length()
		self[1] = self[1] / length
		self[2] = self[2] / length
		self[3] = self[3] / length
		return self
	end,
	---@param self meth.Vec3
	---@return meth.Vec3
	normalized = function(self)
		local length = self:length()
		return vec3(self[1] / length, self[2] / length, self[3] / length)
	end,
	---@param self meth.Vec3
	---@param min meth.Vec3
	---@param max meth.Vec3
	---@return meth.Vec3
	clamp = function(self, min, max)
		self[1] = meth.clamp(self[1], min[1], max[1])
		self[2] = meth.clamp(self[2], min[2], max[2])
		self[3] = meth.clamp(self[3], min[3], max[3])
		return self
	end,
	---@param self meth.Vec3
	---@param min meth.Vec3
	---@param max meth.Vec3
	---@return meth.Vec3
	clamped = function(self, min, max)
		return vec3(
			meth.clamp(self[1], min[1], max[1]),
			meth.clamp(self[2], min[2], max[2]),
			meth.clamp(self[3], min[3], max[3])
		)
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return meth.Vec3
	min = function(self, rhs)
		self[1] = math.min(self[1], rhs[1])
		self[2] = math.min(self[2], rhs[2])
		self[3] = math.min(self[3], rhs[3])
		return self
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return meth.Vec3
	mined = function(self, rhs)
		return vec3(math.min(self[1], rhs[1]), math.min(self[2], rhs[2]), math.min(self[3], rhs[3]))
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return meth.Vec3
	max = function(self, rhs)
		self[1] = math.max(self[1], rhs[1])
		self[2] = math.max(self[2], rhs[2])
		self[3] = math.max(self[3], rhs[3])
		return self
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return meth.Vec3
	maxed = function(self, rhs)
		return vec3(math.max(self[1], rhs[1]), math.max(self[2], rhs[2]), math.max(self[3], rhs[3]))
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return meth.Vec3
	midpoint = function(self, rhs)
		self[1] = (self[1] + rhs[1]) * 0.5
		self[2] = (self[2] + rhs[2]) * 0.5
		self[3] = (self[3] + rhs[3]) * 0.5
		return self
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return meth.Vec3
	midpointed = function(self, rhs)
		return vec3((self[1] + rhs[1]) * 0.5, (self[2] + rhs[2]) * 0.5, (self[3] + rhs[3]) * 0.5)
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@param d float
	---@return meth.Vec3
	move_towardsed = function(self, rhs, d)
		local a_x = rhs[1] - self[1]
		local a_y = rhs[2] - self[2]
		local a_z = rhs[3] - self[3]
		local len = math.sqrt(a_x * a_x + a_y * a_y + a_z * a_z)
		if len <= d or len <= 0.0001 then
			return rhs:copy()
		end
		return vec3(self[1] + a_x / len * d, self[2] + a_y / len * d, self[3] + a_z / len * d)
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@param d float
	---@return meth.Vec3
	move_towards = function(self, rhs, d)
		local a_x = rhs[1] - self[1]
		local a_y = rhs[2] - self[2]
		local a_z = rhs[3] - self[3]
		local len = math.sqrt(a_x * a_x + a_y * a_y + a_z * a_z)
		if len <= d or len <= 0.0001 then
			self:assign_from(rhs)
			return self
		end
		self[1] = self[1] + a_x / len * d
		self[2] = self[2] + a_y / len * d
		self[3] = self[3] + a_z / len * d
		return self
	end,
	---@param self meth.Vec3
	---@param rhs meth.Vec3
	---@return number
	dot = function(self, rhs)
		return self[1] * rhs[1] + self[2] * rhs[2] + self[3] * rhs[3]
	end,
	---@param self meth.Vec3
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	---@return meth.Vec3
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
		return self
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	---@return meth.Vec3
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
		return self
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
		return self
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	---@return meth.Vec3
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
		return self
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
		return self
	end,
	---@param self meth.Vec3
	---@param value number|meth.Vec3
	---@return meth.Vec3
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
		return self
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
inner.meth.vec3_metatable = metatable
