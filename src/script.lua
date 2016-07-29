local ml = require "ml"

local features = {
	{"Sunny", "Hot", "High", "False"},
	{"Sunny", "Hot", "High", "True"},
	{"Overcast", "Hot", "High", "False"},
	{"Rainy", "Mild", "High", "False"},
	{"Rainy", "Cool", "Normal", "False"},
	{"Rainy", "Cool", "Normal", "True"},
	{"Overcast", "Cool", "Normal", "True"},
	{"Sunny", "Mild", "High", "False"},
	{"Sunny", "Cool", "Normal", "False"},
	{"Rainy", "Mild", "Normal", "False"},
	{"Sunny", "Mild", "Normal", "True"},
	{"Overcast", "Mild", "High", "True"},
	{"Overcast", "Hot", "Normal", "False"},
	{"Rainy", "Mild", "High", "True"}
}

local labels = {"No", "No", "Yes", "Yes", "Yes", "No", "Yes", "No", "Yes", "Yes", "Yes", "Yes", "Yes", "No"}

function print_t(t)
	local s = {"return {\n"}
	for i=1,#t do
	  s[#s+1] = "  {"
	  for j=1,#t[i] do
	    s[#s+1] = t[i][j]
	    s[#s+1] = ","
	  end
	  s[#s+1] = "},\n"
	end
	s[#s+1] = "}"
	s = table.concat(s)

	print(s)
end

function print_k(t)
	print("{")
	for k, v in pairs(t) do
		print("  " .. k .. ": " .. v .. ",")
	end
	print("}")
end

-- output
-- local a, b = ml.divide(features, 1, "Sunny")
--
-- print_t(a)
-- print_t(b)

local s = {9, 5}
local m = {{2, 3}, {4, 0}, {3, 2}}
local a = ml.gain(s, m)

print(a)
