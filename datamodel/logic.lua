---@class logic
local logic = {}

---@class chip
---@field number integer
---@field current_x integer
---@field current_y integer
---@field number_url url
---@field view hash

---@class field
---@field elements chip[][]
---@field current_i integer
---@field current_j integer?

---@class position
---@field x integer
---@field y integer

---@alias direction
---| '"left"'
---| '"right"'
---| '"up"'
---| '"down"'

---@comment
---@param value integer
---@param x integer
---@param y integer
---@return chip
function logic.create_chip(value, x, y)
	---@type chip
	local ans = {
		number = value,
		current_x = x,
		current_y = y,
		number_url = msg.url("#DEFAULT"),
		view = hash("DEFAULT"),
	}
	return ans
end

---@comment Create empty field
---@return field
function logic.create_field()

	local field = {
		elements = {}
	}
	for i = 1, 4, 1 do
		local row = {}
		-- for j = 1, 4, 1 do
		-- 	local chip = create_chip()
		-- 	chip.current_x = j
		-- 	chip.current_y = i
		-- 	table.insert(row, chip)	
		-- end
		table.insert(field.elements, row)
	end

	
	return field
end

---@comment
---@param field field
---@return table
function logic.to_string(field)
	local ans = {}
	for i = 1, 4, 1 do
		local row = ""
		for j = 1, 4, 1 do
			---@type chip
			local chip = field.elements[i][j]
			if chip then
				row = row .. chip.number
			else
				row = row .. ""

			end
		end
		table.insert(ans, row)
	end
	return ans
end

---@comment
---@param field field
function logic.print(field)
	local strings = logic.to_string(field)
	for _, value in ipairs(strings) do
		print(value)
	end
end

---@comment Spawn first chips
---@param field field
function logic.init_field(field)
	local min = 1
	local max = 4
	local count = 2

	for _ = 1, count, 1 do
		local x = math.random(min, max)
		local y = math.random(min, max)
		local chip = logic.create_chip(2, x, y)
		pprint(chip)
		field.elements[y][x] = chip
	end
end

---@comment Apply input generic
---@param field field
---@oaram begin position
---@param finish position
---@param inc position
function logic.move_field_generic(field, begin, finish, inc)
	---@type position
	local current = {
		x = begin.x,
		y = begin.y,
	}

	while true do
		if finish.x == current.x and finish.y == current.y then
			return
		end

		current.x = current.x + inc.x
		current.y = current.y + inc.y

		local chip = field.elements[current.y][current.x]
	end


end


---@comment Apply input
---@param field field
---@param direction direction
function logic.move_chip(field, direction)


end



return logic

