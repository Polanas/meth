---@param num number
---@return number
local trunc = function(num)
	if num > 0 then
		return math.floor(num)
	else
		return math.ceil(num)
	end
end
---@param num number
---@return number
local round = function(num)
	return math.floor(num + 0.5)
end
---@param num number
---@return number
local fract = function(num)
	return num - trunc(num)
end
---@param num number
---@return number
local fract_gl = function(num)
	return num - math.floor(num)
end
---@param num number
---@param min number
---@param max number
---@return number
local clamp = function(num, min, max)
	return math.max(math.min(num, max), min)
end

---@class (exact) meth.definitions
return {
	trunc = trunc,
	round = round,
	fract = fract,
	fract_gl = fract_gl,
  clamp = clamp
}
