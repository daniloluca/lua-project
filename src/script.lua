-- import
local ml = require "ml"

-- Data
local features = {
	{"Sol", "Quente", "Elevada", "Fraco"},
	{"Sol", "Quente", "Elevada", "Forte"},
	{"Nuvens", "Quente", "Elevada", "Fraco"},
	{"Chuva", "Ameno", "Elevada", "Fraco"},
	{"Chuva", "Fresco", "Normal", "Fraco"},
	{"Chuva", "Fresco", "Normal", "Forte"},
	{"Nuvens", "Fresco", "Normal", "Forte"},
	{"Sol", "Ameno", "Elevada", "Fraco"},
	{"Sol", "Fresco", "Normal", "Fraco"},
	{"Chuva", "Ameno", "Normal", "Fraco"},
	{"Sol", "Ameno", "Normal", "Forte"},
	{"Nuvens", "Ameno", "Elevada", "Forte"},
	{"Nuvens", "Quente", "Naormal", "Fraco"},
	{"Chuva", "AmeNao", "Elevada", "Forte"}
}

local labels = {"Nao", "Nao", "Sim", "Sim", "Sim", "Nao", "Sim", "Nao", "Sim", "Sim", "Sim", "Sim", "Sim", "Nao"}

-- local features = {
-- 	{"slashdot", "USA", "yes", 18},
-- 	{"google", "France", "yes", 23},
-- 	{"digg", "USA", "yes", 24},
-- 	{"kiwitobes", "France", "yes", 23},
-- 	{"google", "UK", "no", 21},
-- 	{"(direct)", "New Zealand", "no", 12},
-- 	{"(direct)", "UK", "no", 21},
-- 	{"google", "USA", "no", 24},
-- 	{"slashdot", "France", "yes", 19},
-- 	{"digg", "USA", "no", 18},
-- 	{"google", "UK", "no", 18},
-- 	{"kiwitobes", "UK", "no", 19},
-- 	{"digg", "New Zealand", "yes", 12},
-- 	{"slashdot", "UK", "no", 21},
-- 	{"google", "UK", "yes", 18},
-- 	{"kiwitobes", "France", "yes", 19}
-- }
--
-- local labels = {"None", "Premium", "Basic", "Basic", "Premium", "None", "Basic", "Premium", "None", "None", "None", "None", "Basic", "None", "Basic", "Basic"}

-- Examples
local tree = ml.tree(features, labels)

local a = tree.classify({"Sol", "Quente", "Elevada", "Forte"})

-- local a = tree.classify({"(direct)", "USA", "yes", 5})

for k, v in pairs(a) do
	print(k)
end
