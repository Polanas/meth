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
	length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y)
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	add = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] + value
			self[2] = self[2] + value
		else
			self[1] = self[1] + value[1]
			self[2] = self[2] + value[2]
		end
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	sub = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] - value
			self[2] = self[2] - value
		else
			self[1] = self[1] - value[1]
			self[2] = self[2] - value[2]
		end
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	div = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] / value
			self[2] = self[2] / value
		else
			self[1] = self[1] / value[1]
			self[2] = self[2] / value[2]
		end
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	mul = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] * value
			self[2] = self[2] * value
		else
			self[1] = self[1] * value[1]
			self[2] = self[2] * value[2]
		end
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	mod = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] % value
			self[2] = self[2] % value
		else
			self[1] = self[1] % value[1]
			self[2] = self[2] % value[2]
		end
	end,
	---@param self meth.Vec2
	---@param value number|meth.Vec2
	pow = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] ^ value
			self[2] = self[2] ^ value
		else
			self[1] = self[1] ^ value[1]
			self[2] = self[2] ^ value[2]
		end
	end,
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

---@diagnostic disable-next-line: undefined-global
local inner = __inner ~= nil and __inner or {}
---@diagnostic disable-next-line: undefined-global
__inner = inner
inner.vec2_metatable = metatable
