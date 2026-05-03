local logic = require("datamodel.logic")

return function()
	describe("Logic", function()
		test("create corner chip", function()
			local field = logic.create_field()
			logic.create_chip(field, 2, 1, 1)
			local result = logic.to_string(field)
			assert_same(result, {
				"----",
				"----",
				"----",
				"2---",
			})
			logic.print(field)
		end)
		test("move single chip", function()
			local field = logic.create_field()
			logic.create_chip(field, 2, 1, 1)
			logic.move_field(field, "right")
			local result = logic.to_string(field)
			assert_same(result, {
				"----",
				"----",
				"----",
				"---2",
			})
			logic.print(field)
		end)

	end)
end