local meth = require("src.lua.meth")

---@class meth.Vec2
---@field x float
---@field y float
---@operator add(meth.Vec2): meth.Vec2
---@operator add(number): meth.Vec2
---@operator sub(meth.Vec2): meth.Vec2
---@operator sub(number): meth.Vec2
---@operator mul(meth.Vec2): meth.Vec2
---@operator mul(number): meth.Vec2
---@operator div(meth.Vec2): meth.Vec2
---@operator div(number): meth.Vec2
---@operator mod(meth.Vec2): meth.Vec2
---@operator mod(number): meth.Vec2
---@operator unm:meth.Vec2
---@operator pow(meth.Vec2): meth.Vec2
---@operator pow(number): meth.Vec2

---@class meth.Vec2
local methods = {
	---@param self meth.Vec2
	---@return meth.IVec2
	as_ivec2 = function(self)
		return ivec2(math.floor(self[1]), math.floor(self[2]))
	end,
	---@param self meth.Vec2
	---@return float, float
	unpack = function(self)
		return self[1], self[2]
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return meth.Vec2
	assign_from = function(self, rhs)
		self[1] = rhs[1]
		self[2] = rhs[2]
		return self
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	copy = function(self)
		return vec2(self[1], self[2])
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@param s float
	---@return meth.Vec2
	lerped = function(self, rhs, s)
		return vec2(self[1] * (1.0 - s) + rhs[1] * s, self[2] * (1.0 - s) + rhs[2] * s)
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@param s float
	---@return meth.Vec2
	lerp = function(self, rhs, s)
		self[1] = self[1] * (1.0 - s) + rhs[1] * s
		self[2] = self[2] * (1.0 - s) + rhs[2] * s
		return self
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	fract_gl = function(self)
		self[1] = meth.fract_gl(self[1])
		self[2] = meth.fract_gl(self[2])
		return self
	end,
	---@return meth.Vec2
	---@param self meth.Vec2
	fract_gled = function(self)
		return vec2(meth.fract_gl(self[1]), meth.fract_gl(self[2]))
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	trunc = function(self)
		self[1] = meth.trunc(self[1])
		self[2] = meth.trunc(self[2])
		return self
	end,
	---@return meth.Vec2
	---@param self meth.Vec2
	trunced = function(self)
		return vec2(meth.trunc(self[1]), meth.trunc(self[2]))
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	fract = function(self)
		self[1] = meth.fract(self[1])
		self[2] = meth.fract(self[2])
		return self
	end,
	---@return meth.Vec2
	---@param self meth.Vec2
	fracted = function(self)
		return vec2(meth.fract(self[1]), meth.fract(self[2]))
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	round = function(self)
		self[1] = meth.round(self[1])
		self[2] = meth.round(self[2])
		return self
	end,
	---@return meth.Vec2
	---@param self meth.Vec2
	rounded = function(self)
		return vec2(meth.round(self[1]), meth.round(self[2]))
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	ceil = function(self)
		self[1] = math.ceil(self[1])
		self[2] = math.ceil(self[2])
		return self
	end,
	---@return meth.Vec2
	---@param self meth.Vec2
	ceiled = function(self)
		return vec2(math.ceil(self[1]), math.ceil(self[2]))
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	floor = function(self)
		self[1] = math.floor(self[1])
		self[2] = math.floor(self[2])
		return self
	end,
	---@return meth.Vec2
	---@param self meth.Vec2
	floored = function(self)
		return vec2(math.floor(self[1]), math.floor(self[2]))
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	normalize = function(self)
		local length = self:length()
		self[1] = self[1] / length
		self[2] = self[2] / length
		return self
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	normalized = function(self)
		local length = self:length()
		return vec2(self[1] / length, self[2] / length)
	end,
	---@param self meth.Vec2
	---@param min meth.Vec2
	---@param max meth.Vec2
	---@return meth.Vec2
	clamp = function(self, min, max)
		self[1] = meth.clamp(self[1], min[1], max[1])
		self[2] = meth.clamp(self[2], min[2], max[2])
		return self
	end,
	---@param self meth.Vec2
	---@param min meth.Vec2
	---@param max meth.Vec2
	---@return meth.Vec2
	clamped = function(self, min, max)
		return vec2(meth.clamp(self[1], min[1], max[1]), meth.clamp(self[2], min[2], max[2]))
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return meth.Vec2
	min = function(self, rhs)
		self[1] = math.min(self[1], rhs[1])
		self[2] = math.min(self[2], rhs[2])
		return self
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return meth.Vec2
	mined = function(self, rhs)
		return vec2(math.min(self[1], rhs[1]), math.min(self[2], rhs[2]))
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return meth.Vec2
	max = function(self, rhs)
		self[1] = math.max(self[1], rhs[1])
		self[2] = math.max(self[2], rhs[2])
		return self
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return meth.Vec2
	maxed = function(self, rhs)
		return vec2(math.max(self[1], rhs[1]), math.max(self[2], rhs[2]))
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return meth.Vec2
	midpoint = function(self, rhs)
		self[1] = (self[1] + rhs[1]) * 0.5
		self[2] = (self[2] + rhs[2]) * 0.5
		return self
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return meth.Vec2
	midpointed = function(self, rhs)
		return vec2((self[1] + rhs[1]) * 0.5, (self[2] + rhs[2]) * 0.5)
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@param d float
	---@return meth.Vec2
	move_towardsed = function(self, rhs, d)
		local a_x = rhs[1] - self[1]
		local a_y = rhs[2] - self[2]
		local len = math.sqrt(a_x * a_x + a_y * a_y)
		if len <= d or len <= 0.0001 then
			return rhs:copy()
		end
		return vec2(self[1] + a_x / len * d, self[2] + a_y / len * d)
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@param d float
	---@return meth.Vec2
	move_towards = function(self, rhs, d)
		local a_x = rhs[1] - self[1]
		local a_y = rhs[2] - self[2]
		local len = math.sqrt(a_x * a_x + a_y * a_y)
		if len <= d or len <= 0.0001 then
			self[1] = rhs[1]
			self[2] = rhs[2]
			return self
		end
		self[1] = self[1] + a_x / len * d
		self[2] = self[2] + a_y / len * d
		return self
	end,
	---@param self meth.Vec2
	---@param rhs meth.Vec2
	---@return number
	dot = function(self, rhs)
		return self[1] * rhs[1] + self[2] * rhs[2]
	end,
	---@param self meth.Vec2
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y)
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	---@return meth.Vec2
	add = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] + value
			self[2] = self[2] + value
		else
			self[1] = self[1] + value[1]
			self[2] = self[2] + value[2]
		end
		return self
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	---@return meth.Vec2
	sub = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] - value
			self[2] = self[2] - value
		else
			self[1] = self[1] - value[1]
			self[2] = self[2] - value[2]
		end
		return self
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	---@return meth.Vec2
	div = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] / value
			self[2] = self[2] / value
		else
			self[1] = self[1] / value[1]
			self[2] = self[2] / value[2]
		end
		return self
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	---@return meth.Vec2
	mul = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] * value
			self[2] = self[2] * value
		else
			self[1] = self[1] * value[1]
			self[2] = self[2] * value[2]
		end
		return self
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	---@return meth.Vec2
	mod = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] % value
			self[2] = self[2] % value
		else
			self[1] = self[1] % value[1]
			self[2] = self[2] % value[2]
		end
		return self
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	---@return meth.Vec2
	pow = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] ^ value
			self[2] = self[2] ^ value
		else
			self[1] = self[1] ^ value[1]
			self[2] = self[2] ^ value[2]
		end
		return self
	end,
	---@param self meth.Vec2
	---@return meth.Vec2
	neg = function(self)
		self[1] = -self[1]
		self[2] = -self[2]
		return self
	end,
	type = "Vec2",
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
	---@param self meth.Vec2
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
			return vec2(a + b[1], a + b[2])
		elseif type(b) == "number" then
			return vec2(a[1] + b, a[2] + b)
		else
			return vec2(a[1] + b[1], a[2] + b[2])
		end
	end,
	__sub = function(a, b)
		if type(a) == "number" then
			return vec2(a - b[1], a - b[2])
		elseif type(b) == "number" then
			return vec2(a[1] - b, a[2] - b)
		else
			return vec2(a[1] - b[1], a[2] - b[2])
		end
	end,

	__mul = function(a, b)
		if type(a) == "number" then
			return vec2(a * b[1], a * b[2])
		elseif type(b) == "number" then
			return vec2(a[1] * b, a[2] * b)
		else
			return vec2(a[1] * b[1], a[2] * b[2])
		end
	end,
	__div = function(a, b)
		if type(a) == "number" then
			return vec2(a / b[1], a / b[2])
		elseif type(b) == "number" then
			return vec2(a[1] / b, a[2] / b)
		else
			return vec2(a[1] / b[1], a[2] / b[2])
		end
	end,

	__mod = function(a, b)
		if type(a) == "number" then
			return vec2(a % b[1], a % b[2])
		elseif type(b) == "number" then
			return vec2(a[1] % b, a[2] % b)
		else
			return vec2(a[1] % b[1], a[2] % b[2])
		end
	end,
	__unm = function(a)
		return vec2(-a[1], -a[2])
	end,
	__pow = function(a, b)
		if type(a) == "number" then
			return vec2(a ^ b[1], a ^ b[2])
		elseif type(b) == "number" then
			return vec2(a[1] ^ b, a[2] ^ b)
		else
			return vec2(a[1] ^ b[1], a[2] ^ b[2])
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

---@return meth.Vec2
---@overload fun(x: number, y: number): meth.Vec2
---@overload fun(value: number): meth.Vec2
---@overload fun(): meth.Vec2
---@diagnostic disable-next-line: lowercase-global
function vec2(x, y)
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
inner.meth.vec2_metatable = metatable

local test = require("src.lua.lopa-test")
test.test_module("vec2", {
	addition = function()
		test.case("vec + vec", function()
			test.assert_eq(vec2(1, 1) + vec2(2, 3), vec2(3, 4))
		end)
		test.case("vec + num", function()
			test.assert_eq(vec2(1, 2) + 2, vec2(3, 4))
		end)
		test.case("num + vec", function()
			test.assert_eq(2 + vec2(1, 2), vec2(3, 4))
		end)
	end,
})
