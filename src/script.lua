local ml = require "ml"

local data = {
	{"slashdot","USA","yes",18,"None"},
    {"google","France","yes",23,"Premium"},
    {"digg","USA","yes",24,"Basic"},
    {"kiwitobes","France","yes",23,"Basic"},
    {"google","UK","no",21,"Premium"},
    {"(direct)","New Zealand","no",12,"None"},
    {"(direct)","UK","no",21,"Basic"},
    {"google","USA","no",24,"Premium"},
    {"slashdot","France","yes",19,"None"},
    {"digg","USA","no",18,"None"},
    {"google","UK","no",18,"None"},
    {"kiwitobes","UK","no",19,"None"},
    {"digg","New Zealand","yes",12,"Basic"},
    {"slashdot","UK","no",21,"None"},
    {"google","UK","yes",18,"Basic"},
    {"kiwitobes","France","yes",19,"Basic"},
}

function print_t(t)
	local s = {"return {\n"}
	for i=1,#t do
	  s[#s+1] = "\t{"
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

local a, b = ml.devideset(data, 4, 20)

print_t(a)
print_t(b)
