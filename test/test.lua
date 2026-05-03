require "debugger":start "127.0.0.1:12306":event "wait"
print "ok"

local deftest = require "deftest.deftest"

local test_logic = require "test.test_logic"

function init(self)
	deftest.add(test_logic)
	deftest.run({ coverage = { enabled = false }, pattern = nil })
end