---@class logic
local logic = {}

---@class chip
---@field number integer
---@field current_x integer
---@field current_y integer
---@field view hash
---@field number_url url

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

---@commment
---@param x integer
---@param y integer
---@return position
local function pos(x, y)
	return {
		x = x, 
		y = y,
	}
end

---@comment Create empty field
---@return field
function logic.create_field()

	local field = {
		elements = {}
	}
	for _ = 1, 4, 1 do
		local row = {}
		table.insert(field.elements, row)
	end
	return field
end

---@comment
---@param field field
---@param value integer
---@param x integer
---@param y integer
---@return chip
function logic.create_chip(field, value, x, y)
	---@type chip
	local chip = {
		number = value,
		current_x = x,
		current_y = y,
		view = hash("#NOT_DEFINED"),
		number_url = msg.url("#NOT_DEFINED"),
	}
	field.elements[y][x] = chip
	return chip
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
		logic.create_chip(field, 2, x, y)
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
		x = finish.x,
		y = finish.y,
	}

	local free_x, free_y
	local busy_x, busy_y
	while true do
		if begin.x == current.x and begin.y == current.y then
			return
		end

		current.x = current.x - inc.x
		current.y = current.y - inc.y

		local chip = field.elements[current.y][current.x]
		if not chip then
			free_x = current.x
			free_y = current.y
			break
		end
	end

	while true do
		if begin.x == current.x and begin.y == current.y then
			return
		end

		current.x = current.x - inc.x
		current.y = current.y - inc.y

		local chip = field.elements[current.y][current.x]
		if chip then
			busy_x = current.x
			busy_y = current.y
		end
	end

	local chip = field.elements[busy_y][busy_x]
	field.elements[busy_y][busy_x] = nil
	field.elements[free_y][free_x] = chip

end


---@comment Apply input
---@param field field
---@param direction direction
function logic.move_field(field, direction)
	if direction == "right" then
		logic.move_field_generic(field, pos(1, 1), pos(4, 1), pos(1, 0))
	end
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
				row = row .. "-"

			end
		end
		table.insert(ans, row)
	end
	table.reverse(ans)
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


return logic

