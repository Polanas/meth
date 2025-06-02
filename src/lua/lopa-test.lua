---Deeply compare two objects.
---@param a any
---@param b any
---@param ignore_metatable boolean?
---@return boolean
local function deep_equals(a, b, ignore_metatable)
	-- same object
	if a == b then
		return true
	end

	local o1Type = type(a)
	local o2Type = type(b)
	--- different type
	if o1Type ~= o2Type then
		return false
	end
	--- same type but not table, already compared above
	if o1Type ~= "table" then
		return false
	end

	-- use metatable method
	if not ignore_metatable then
		local mt1 = getmetatable(a)
		if mt1 and mt1.__eq then
			--compare using built in method
			return a == b
		end
	end

	-- iterate over o1
	for key1, value1 in pairs(a) do
		local value2 = b[key1]
		if value2 == nil or deep_equals(value1, value2, ignore_metatable) == false then
			return false
		end
	end

	--- check keys in o2 but missing from o1
	for key2, _ in pairs(b) do
		if a[key2] == nil then
			return false
		end
	end
	return true
end

---@class (exact) lopa-test.module
---@field name string
---@field tests table<string, lopa-test.test>

---@class lopa-test.test
---@field name string
---@field fun fun()
---@field full_name string?

---@class lopa-test.case
---@field name string
---@field fun fun()

---@class lopa-test.failed_case
---@field name string
---@field error any

---@type lopa-test.module[]
local modules = {}

---@type lopa-test.failed_case?
local failed_case = nil

---@class lopa-test.defs
local M = {
	---@param name string
	---@param test_fns table<string, fun()>
	test_module = function(name, test_fns)
		---@type lopa-test.test[]
		local tests = {}
		for name, fun in pairs(test_fns) do
			table.insert(tests, { name = name, fun = fun })
		end
		table.insert(modules, { name = name, tests = tests })
	end,

	---@param bool boolean
	assert = function(bool)
		if not bool then
			error("assert failed")
		end
	end,

	---@param name string
	---@param case fun()
	case = function(name, case)
		local success, result = pcall(case)
		if not success then
			failed_case = {
				name = name,
				error = result,
			}
		end
	end,
	assert_eq = function(a, b)
		if a ~= b then
			error("assert_eq failed")
		end
	end,
	assert_neq = function(a, b)
		if a == b then
			error("assert_neq failed")
		end
	end,
	assert_eq_shallow = function(a, b)
		if a == b then
			return
		end
		local type_a = type(a)
		if type_a ~= "table" then
			error("assert_eq_shallow failed")
		end

		for a_key, a_value in pairs(a) do
			for b_key, b_value in pairs(b) do
				if a_key == b_key and a_value == b_value then
					goto continue
				else
					--TODO: print whats wrong as well as keys/values
					error("assert_eq_shallow failed")
				end
				::continue::
			end
		end
	end,
	assert_eq_deep = function(a, b)
		if not deep_equals(a, b) then
			error("assert_eq_deep failed")
		end
	end,
	assert_neq_shallow = function(a, b)
		if a ~= b then
			return
		end

		local type_a = type(a)
		if type_a ~= "table" then
			error("assert_neq_shallow failed")
		end

		for a_key, a_value in pairs(a) do
			for b_key, b_value in pairs(b) do
				if a_key ~= b_key and a_value ~= b_value then
					goto continue
				else
					--TODO: print whats wrong as well as keys/values
					error("assert_neq_shallow failed")
				end
				::continue::
			end
		end
	end,
	assert_neq_deep = function(a, b)
		if not deep_equals(a, b) then
			error("assert_neq_deep failed")
		end
	end,
	---@private
	execute_tests = function()
		---@type lopa-test.test[]
		local tests = {}
		for _, mod in pairs(modules) do
			for _, test in pairs(mod.tests) do
				test.full_name = mod.name .. "." .. test.name
				table.insert(tests, test)
			end
		end
		local test_s = #tests == 1 and "" or "s"
		print("running " .. #tests .. " test" .. test_s)
		print()

		---@class lopa-test.failed-test
		---@field full_name string
		---@field error any?
		---@field case_name string?

		---@type lopa-test.failed-test[]
		local failed_tests = {}
		local success_amount = 0

		---@type __inner
		local inner = _G["__inner"]

		inner.lopa_test.start_timer()
		for _, test in pairs(tests) do
			local success, result = pcall(test.fun)
			local failed = not success or failed_case ~= nil
			if failed then
				print("test " .. test.full_name .. ": " .. "\x1b[31mFAILED\x1b[0m")
				if failed_case ~= nil then
					table.insert(failed_tests, {
						full_name = test.full_name,
						case_name = failed_case.name,
						error = failed_case.error,
					})
				end
				if result ~= nil then
					table.insert(failed_tests, {
						full_name = test.full_name,
						error = result,
					})
				end
			else
				print("test " .. test.full_name .. ": " .. "\x1b[32mok\x1b[0m")
				success_amount = success_amount + 1
			end
			failed_case = nil
		end
		local diff = inner.lopa_test.end_timer()

		if #failed_tests > 0 then
			print()
			print("failures: ")
			print()
			for _, test in ipairs(failed_tests) do
				local name = test.case_name == nil and test.full_name
					or string.format('%s, case: "%s"', test.full_name, test.case_name)
				print(string.format("---- %s ----", name))
				print(test.error)
				print()
			end
		end
		if #tests > 0 then
			print()
		end

		local test_result = #failed_tests == 0 and "\x1b[32mok\x1b[0m" or "\x1b[31mFAILED\x1b[0m"
		print(
			string.format(
				"test result: %s. %s passed; %s failed; finished in %.4f seconds",
				test_result,
				success_amount,
				#failed_tests,
				diff
			)
		)
	end,
}
return M
