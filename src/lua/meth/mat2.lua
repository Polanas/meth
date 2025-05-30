---@class meth.Mat2
---@field x1 float
---@field y1 float
---@field x2 float
---@field y2 float
---@operator add(meth.Mat2): meth.Mat2
---@operator add(number): meth.Mat2
---@operator sub(meth.Mat2): meth.Mat2
---@operator sub(number): meth.Mat2
---@operator mul(meth.Mat2): meth.Mat2
---@operator mul(meth.Vec2): meth.Vec2
---@operator mul(number): meth.Mat2

---@class meth.Mat2
local methods = {
	---@param self meth.Mat2
	---@param value number|meth.Mat2
	---@return meth.Mat2
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
	---@param self meth.Mat2
	---@param value number|meth.Mat2
	---@return meth.Mat2
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
	---@param self meth.Mat2
	---@param value number|meth.Mat2
	---@return meth.Mat2
	mul = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] * value
			self[2] = self[2] * value
			self[3] = self[3] * value
			self[4] = self[4] * value
		else
			---@cast value meth.Mat2
			local a, c, b, d = self[1], self[2], self[3], self[4]
			local e, g, f, h = value[1], value[2], value[3], value[4]
			self[1] = a * e + b * g
			self[2] = c * e + d * g
			self[3] = a * f + b * h
			self[4] = c * f + d * h
		end
		return self
	end,
	type = "Mat2",
}

local metatable = {
	__newindex = function(self, key, value)
		if key == "x1" then
			self[1] = value
		elseif key == "y1" then
			self[2] = value
		elseif key == "x2" then
			self[3] = value
		elseif key == "y2" then
			self[4] = value
		end
	end,
	---@param self meth.Vec2
	__index = function(self, value)
		if value == "x1" then
			return self[1]
		elseif value == "y1" then
			return self[2]
		elseif value == "x2" then
			return self[3]
		elseif value == "y2" then
			return self[4]
		else
			return methods[value]
		end
	end,
	__add = function(a, b)
		if type(a) == "number" then
			return mat2(a + b[1], a + b[2], a + b[3], a + b[4])
		elseif type(b) == "number" then
			return mat2(a[1] + b, a[2] + b, a[3] + b, a[4] + b)
		else
			return mat2(a[1] + b[1], a[2] + b[2], a[3] + b[3], a[4] + b[4])
		end
	end,
	__sub = function(a, b)
		if type(a) == "number" then
			return mat2(a - b[1], a - b[2], a - b[3], a - b[4])
		elseif type(b) == "number" then
			return mat2(a[1] - b, a[2] - b, a[3] - b, a[4] - b)
		else
			return mat2(a[1] - b[1], a[2] - b[2], a[3] - b[3], a[4] - b[4])
		end
	end,
	__mul = function(a, b)
		if type(a) == "number" then
			return mat2(a * b[1], a * b[2], a * b[3], a * b[4])
		elseif type(b) == "number" then
			return mat2(a[1] * b, a[2] * b, a[3] * b, a[4] * b)
		elseif type(b) == "table" and b.type == "Vec2" then
			local x, y = b[1], b[2]
			local a, b, c, d = a[1], a[2], a[3], a[4]
			return vec2(a * x + c * y, b * x + d * y)
		else
			local a, c, b, d = a[1], a[2], a[3], a[4]
			local e, g, f, h = b[1], b[2], b[3], b[4]
			return mat2(a * e + b * g, c * e + d * g, a * f + b * h, c * f + d * h)
		end
	end,
	__tostring = function(self)
		return "(x_axis: (" .. self[1] .. ", " .. self[2] .. "); y_axis: (" .. self[3] .. ", " .. self[4] .. "))"
	end,
}

---@return meth.Mat2
---@overload fun(): meth.Mat2
---@overload fun(value: number): meth.Mat2
---@overload fun(value: meth.Vec4): meth.Mat2
---@overload fun(x_axis: meth.Vec2, y_axis: meth.Vec2): meth.Mat2
---@overload fun(x1: number, y1: number, x2: number, y2: number): meth.Mat2
function mat2(x1, y1, x2, y2)
	if type(x1) == "table" and x1.type and type(y1) == "table" and y1.type then
		local x1_type, y1_type = x1.type, y1.type
		if (x1_type == "Vec2" or x1_type == "IVec2") and (y1_type == "Vec2" or y1_type == "IVec2") then
			---@cast x1 meth.Vec2
			---@cast y1 meth.Vec2
			return setmetatable({ x1.x, x1.y, y1.x, y1.y }, metatable)
		elseif x1_type == "Vec4" or x1_type == "IVec4" then
			---@cast x1 meth.Vec4
			return setmetatable({ x1.x, x1.y, x1.z, x1.w }, metatable)
		end
		return setmetatable({ 0, 0, 0, 0 }, metatable)
	elseif x1 and y1 and x2 and y2 then
		return setmetatable({ x1, y1, x2, y2 }, metatable)
	elseif x1 and not y1 then
		return setmetatable({ x1, x1, x1, x1 }, metatable)
	else
		return setmetatable({ 0, 0, 0, 0 }, metatable)
	end
end

local inner = _G["__inner"]
---@type __inner
local inner = inner ~= nil and inner or {}
_G["__inner"] = inner
inner.mat2_metatable = metatable

---@class meth.Mat2.definitions
local Mat2 = {
	---@return meth.Mat2
	---@param angle number (in radians)
	from_angle = function(angle)
		local sin, cos = math.sin(angle), math.cos(angle)
		return mat2(cos, -sin, sin, cos)
	end,
	ZERO = mat2(),
	IDENTITY = mat2(1, 0, 0, 1),
}

return Mat2
