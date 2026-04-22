local logic = require("datamodel.logic")

return function()
	describe("Logic", function()
		test("create", function()
			local field = logic.create_field()
			logic.init_field(field)
			logic.print(field)
		end)

	end)
end