---@class meth.Mat3
---@field x1 float
---@field y1 float
---@field z1 float
---@field x2 float
---@field y2 float
---@field z2 float
---@field x3 float
---@field y3 float
---@field z3 float
---@operator add(meth.Mat3): meth.Mat3
---@operator add(number): meth.Mat3
---@operator sub(meth.Mat3): meth.Mat3
---@operator sub(number): meth.Mat3
---@operator mul(meth.Mat3): meth.Mat3
---@operator mul(meth.Vec3): meth.Vec3
---@operator mul(number): meth.Mat3
---@operator div(number): meth.Mat3

---@class meth.Mat3
local methods = {
	---@param self meth.Mat3
	---@param value number|meth.Mat3
	---@return meth.Mat3
	add = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] + value
			self[2] = self[2] + value
			self[3] = self[3] + value
			self[4] = self[4] + value
			self[5] = self[5] + value
			self[6] = self[6] + value
			self[7] = self[7] + value
			self[8] = self[8] + value
			self[9] = self[9] + value
		else
			self[1] = self[1] + value[1]
			self[2] = self[2] + value[2]
			self[3] = self[3] + value[3]
			self[4] = self[4] + value[4]
			self[5] = self[5] + value[5]
			self[6] = self[6] + value[6]
			self[7] = self[7] + value[7]
			self[8] = self[8] + value[8]
			self[9] = self[9] + value[9]
		end
		return self
	end,
	---@param self meth.Mat3
	---@param value number|meth.Mat3
	---@return meth.Mat3
	sub = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] - value
			self[2] = self[2] - value
			self[3] = self[3] - value
			self[4] = self[4] - value
			self[5] = self[5] - value
			self[6] = self[6] - value
			self[7] = self[7] - value
			self[8] = self[8] - value
			self[9] = self[9] - value
		else
			self[1] = self[1] - value[1]
			self[2] = self[2] - value[2]
			self[3] = self[3] - value[3]
			self[4] = self[4] - value[4]
			self[5] = self[5] - value[5]
			self[6] = self[6] - value[6]
			self[7] = self[7] - value[7]
			self[8] = self[8] - value[8]
			self[9] = self[9] - value[9]
		end
		return self
	end,
	---@param self meth.Mat3
	---@param value number|meth.Mat3
	---@return meth.Mat3
	mul = function(self, value)
		if type(value) == "number" then
			self[1] = self[1] * value
			self[2] = self[2] * value
			self[3] = self[3] * value
			self[4] = self[4] * value
			self[5] = self[5] * value
			self[6] = self[6] * value
			self[7] = self[7] * value
			self[8] = self[8] * value
			self[9] = self[9] * value
		else
			---@cast value meth.Mat3
			local a, d, g, b, e, h, c, f, i =
				self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9]
			local j, m, p, k, n, q, l, o, r =
				value[1], value[2], value[3], value[4], value[5], value[6], value[7], value[8], value[9]

			self[1] = a * j + b * m + c * p
			self[2] = d * j + e * m + f * p
			self[3] = g * j + h * m + i * p

			self[4] = a * k + b * n + c * q
			self[5] = d * k + e * n + f * q
			self[6] = g * k + h * n + i * q

			self[7] = a * l + b * o + c * r
			self[8] = d * l + e * o + f * r
			self[9] = g * l + h * o + i * r
		end
		return self
	end,
	type = "Mat3",
}

local metatable = {
	__newindex = function(self, key, value)
		if key == "x1" then
			self[1] = value
		elseif key == "y1" then
			self[2] = value
		elseif key == "z1" then
			self[3] = value
		elseif key == "x2" then
			self[4] = value
		elseif key == "y2" then
			self[5] = value
		elseif key == "z2" then
			self[6] = value
		elseif key == "x3" then
			self[7] = value
		elseif key == "y3" then
			self[8] = value
		elseif key == "z3" then
			self[9] = value
		end
	end,
	---@param self meth.Vec2
	__index = function(self, value)
		if value == "x1" then
			return self[1]
		elseif value == "y1" then
			return self[2]
		elseif value == "z1" then
			return self[3]
		elseif value == "x2" then
			return self[4]
		elseif value == "y2" then
			return self[5]
		elseif value == "z2" then
			return self[6]
		elseif value == "x3" then
			return self[7]
		elseif value == "y3" then
			return self[8]
		elseif value == "z3" then
			return self[9]
		else
			return methods[value]
		end
	end,
	__add = function(a, b)
		if type(a) == "number" then
			return mat3(a + b[1], a + b[2], a + b[3], a + b[4], a + b[5], a + b[6], a + b[7], a + b[8], a + b[9])
		elseif type(b) == "number" then
			return mat3(a[1] + b, a[2] + b, a[3] + b, a[4] + b, a[5] + b, a[6] + b, a[7] + b, a[8] + b, a[9] + b)
		else
			-- stylua: ignore
			return mat3(
				a[1] + b[1], a[2] + b[2], a[3] + b[3],
        a[4] + b[4], a[5] + b[5], a[6] + b[6],
        a[7] + b[7], a[8] + b[8], a[9] + b[9]
			)
		end
	end,
	__sub = function(a, b)
		if type(a) == "number" then
			return mat3(a - b[1], a - b[2], a - b[3], a - b[4], a - b[5], a - b[6], a - b[7], a - b[8], a - b[9])
		elseif type(b) == "number" then
			return mat3(a[1] - b, a[2] - b, a[3] - b, a[4] - b, a[5] - b, a[6] - b, a[7] - b, a[8] - b, a[9] - b)
		else
			-- stylua: ignore
			return mat3(
				a[1] - b[1], a[2] - b[2], a[3] - b[3],
        a[4] - b[4], a[5] - b[5], a[6] - b[6],
        a[7] - b[7], a[8] - b[8], a[9] - b[9]
			)
		end
	end,
	__mul = function(a, b)
		if type(a) == "number" then
			return mat3(a * b[1], a * b[2], a * b[3], a * b[4], a * b[5], a * b[6], a * b[7], a * b[8], a * b[9])
		elseif type(b) == "number" then
			return mat3(a[1] * b, a[2] * b, a[3] * b, a[4] * b, a[5] * b, a[6] * b, a[7] * b, a[8] * b, a[9] * b)
		elseif type(b) == "table" and b.type == "Vec3" then
			local x1, y1, z1 = a[1], a[2], a[3]
			local x2, y2, z2 = a[4], a[5], a[6]
			local x3, y3, z3 = a[7], a[8], a[9]
			local a1, a2, a3 = b[1], b[2], b[3]

      -- stylua: ignore
      return vec3(
        a1 * x1 + a2 * x2 + a3 * x3,
        a1 * y1 + a2 * y2 + a3 * y3,
        a1 * z1 + a2 * z2 + a3 * z3
      )
		else
			local j, m, p, k, n, q, l, o, r = b[1], b[2], b[3], b[4], b[5], b[6], b[7], b[8], b[9]
			local a, d, g, b, e, h, c, f, i = a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9]
      -- stylua: ignore
      return mat3(
        a * j + b * m + c * p,
        d * j + e * m + f * p,
        g * j + h * m + i * p,
        a * k + b * n + c * q,
        d * k + e * n + f * q,
        g * k + h * n + i * q,
        a * l + b * o + c * r,
        d * l + e * o + f * r,
        g * l + h * o + i * r
      )
		end
	end,
	__div = function(a, b)
		if type(a) == "number" then
			return mat3(a / b[1], a / b[2], a / b[3], a / b[4], a / b[5], a / b[6], a / b[7], a / b[8], a / b[9])
		elseif type(b) == "number" then
			return mat3(a[1] / b, a[2] / b, a[3] / b, a[4] / b, a[5] / b, a[6] / b, a[7] / b, a[8] / b, a[9] / b)
		end
	end,
	__eq = function(a, b)
    -- stylua: ignore
		return a[1] == b[1] and a[2] == b[2] and a[3] == b[3]
			and a[4] == b[4] and a[5] == b[5] and a[6] == b[6]
			and a[7] == b[7] and a[8] == b[8] and a[9] == b[9]
	end,
	__unm = function(self)
		return vec4(-self[1], -self[2], -self[3], -self[4])
	end,
	__tostring = function(s)
    -- stylua: ignore
		return string.format(
			"(%s, %s, %s,\n %s, %s, %s,\n %s, %s, %s)",
			s[1], s[2], s[3],
			s[4], s[5], s[6],
			s[7], s[8], s[9]
		)
	end,
	__len = function()
		return 9
	end,
}

---@param t string
local function is_vec3(t)
	return t == "IVec3" or t == "Vec3"
end

---@return meth.Mat3
---@overload fun(): meth.Mat3
---@overload fun(value: number): meth.Mat3
---@overload fun(x_axis: meth.Vec3, y_axis: meth.Vec3, z_axis: meth.Vec3): meth.Mat3
---@overload fun(x1: number, y1: number, z1: number, x2: number, y2: number, z2: number, x3: number, y3: number, z3: number): meth.Mat3
function mat3(x1, y1, z1, x2, y2, z2, x3, y3, z3)
	if type(x1) == "table" and x1.type and type(y1) == "table" and y1.type and type(z1) == "table" and z1.type then
		local x1_type, y1_type, z1_type = x1.type, y1.type, z1.type
		if is_vec3(x1_type) and is_vec3(y1_type) and is_vec3(z1_type) then
			---@cast x1 meth.Vec3
			---@cast y1 meth.Vec3
			---@cast z1 meth.Vec3
			return setmetatable({ x1.x, x1.y, x1.z, y1.x, y1.y, y1.z, z1.x, z1.y, z1.z }, metatable)
		end
		return setmetatable({ 0, 0, 0, 0, 0, 0, 0, 0, 0 }, metatable)
	elseif x1 and y1 and z1 and x2 and y2 and z2 and x3 and y3 and z3 then
		return setmetatable({ x1, y1, z1, x2, y2, z2, x3, y3, z3 }, metatable)
	elseif x1 and not y1 then
		return setmetatable({ x1, x1, x1, x1, x1, x1, x1, x1, x1 }, metatable)
	else
		return setmetatable({ 0, 0, 0, 0, 0, 0, 0, 0, 0 }, metatable)
	end
end

local inner = _G["__inner"]
---@type __inner
local inner = inner ~= nil and inner or {}
_G["__inner"] = inner
inner.meth.mat2_metatable = metatable

---@class meth.Mat3.definitions
local Mat3 = {
	-- ---@return meth.Mat3
	-- ---@param angle number (in radians)
	-- from_angle = function(angle)
	-- 	local sin, cos = math.sin(angle), math.cos(angle)
	-- 	return mat2(cos, -sin, sin, cos)
	-- end,
	ZERO = mat3(),
	IDENTITY = mat3(1, 0, 0, 0, 1, 0, 0, 0, 1),
}

local t = require("src.lua.lopa-test")
t.test_module("mat3", {
	multiplication = function()
		t.case("matrix * vector", function()
      -- stylua: ignore
      local m1 = mat3(
        1,4,7,
        2,5,8,
        3,6,9
      )
			local vec = vec3(1, 2, 3)
			t.assert_eq(m1 * vec, vec3(14., 32., 50.))
		end)
		t.case("matrix * matrix", function()
      -- stylua: ignore
      local m1 = mat3(
        1,4,7,
        2,5,8,
        3,6,9
      )
      -- stylua: ignore
      local m2 = mat3(
        9,6,3,
        8,5,2,
        7,4,1
      )

      -- stylua: ignore
			t.assert_eq(m1 * m2, mat3(
        30, 84, 138,
        24, 69, 114,
        18, 54, 90))
		end)
	end,
})

return Mat3
