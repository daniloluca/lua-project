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

function printtree(tree)
	if tree.results ~= nil then
		print(tostring(tree.results))
	else
		print(tostring(tree.col)..":"..tostring(tree.value).."? ")
		print(" T->  ")
		printtree(tree.tb, "   ")
		print(indent.."F->  ")
		printtree(tree.fb, "   ")
	end
end

-- local a, b = ml.divideset(data, 4, 20)

-- print_t(a)
-- print_t(b)

-- print_k(ml.uniquecounts(data));

-- local a, b = ml.divideset(data,4,20)
-- print_t(a)
-- print_k(ml.uniquecounts(a))
-- print("")
-- print_t(b)
-- print_k(ml.uniquecounts(b))

-- local set1, set2=ml.divideset(data,4,20)
-- print(ml.entropy(set1), ml.entropy(set2))

-- print(ml.entropy(data))


local tree=ml.buildtree(data)

printtree(tree);
-- print(tree.col)
-- print(tree.value)
-- print(tree.results)
-- print("")
-- print(tree.tb.col)
-- print(tree.tb.value)
-- print(tree.tb.results)
-- print("")
-- print(tree.tb.tb.col)
-- print(tree.tb.tb.value)
-- print(tree.tb.tb.results)
-- print("")
-- print(tree.tb.fb.col)
-- print(tree.tb.fb.value)
-- print(tree.tb.fb.results)
