local ml = {}

function ml.test()
	print('ok')
end

function ml.train(features, label)
	return function(input)
		local output = input

		return output
	end
end

-- Divides a set on a specific column. Can handle numeric or nominal values
function ml.divideset(rows, column, value)
	-- Make a function that tells us if a row is in the first group (true) or the second group (false)
	local split_function;
	-- check if the value is a number i.e int or float
	if type(value) == "number" then
		split_function = function(row)
			return row[column] >= value
		end
	elseif type(value) == "string" then
		split_function = function(row)
			return row[column] == value
		end
	end

	-- Divide the rows into two sets and return them
	local set1 = {}
	local set2 = {}
	for k, v in pairs(rows) do
		if split_function(v) then
			set1[#set1+1] = v
		else
			set2[#set2+1] = v
		end
	end

	return set1, set2
end

-- Create counts of possible results (the last column of each row is the result)
function ml.uniquecounts(rows)
	local results = {}
	for k, v in pairs(rows) do
		-- The result is the last column
		r=v[#v]
		if results[r] == nil then
			results[r] = 0
		end
		results[r] = results[r] + 1
	end
	return results
end

-- Entropy is the sum of p(x)log(p(x)) across all
-- the different possible results
function ml.entropy(rows)
	local log2 = function(x)
		return math.log(x)/math.log(2)
	end
	local results = ml.uniquecounts(rows)
	-- Now calculate the entropy
	local ent = 0.0
	for k, v in pairs(results) do
		local p = tonumber(results[k]/#rows)
		ent = ent-p*log2(p)
	end
	return ent
end

ml.decisionnode = {}
ml.decisionnode.__index = ml.decisionnode
function ml.decisionnode.create(col, value, results, tb, fb)
	local self = {}
	setmetatable(self, ml.decisionnode)
	self.col = col
	self.value = value
	self.results = results
	self.tb = tab
	self.fb = fb

	if col ~= nil then
		self.col = -1
	end
	if value ~= nil then
		self.value = {}
	end
	if results ~= nil then
		self.results = {}
	end
	if tb ~= nil then
		self.tb = {}
	end
	if fb ~= nil then
		self.fb = {}
	end
	return self
end

function ml.buildtree(rows, scoref) -- rows is the set, either whole dataset or part of it in the recursive call,
	-- scoref is the method to measure heterogeneity. By default it's entropy.
	if scoref == nil then
		scoref = ml.entropy
	end
	-- len(rows) is the number of units in a set
	if #rows == 0 then
		return ml.decisionnode()
	end
	local current_score = scoref(rows)

	-- Set up some variables to track the best criteria
	local best_gain = 0.0
	local best_criteria = {}
	local best_sets = {}

	-- count the # of attributes/columns
	-- It's -1 because the last one is the target attribute and it does not count.
	column_count = (#rows[1])-1
	for col=1, column_count do
		-- Generate the list of all possible different values in the considered column
		column_values = {}
		for k, row in pairs(rows) do
			column_values[row[col]] = 1
			-- Now try dividing the rows up for each value in this column
			for value in pairs(column_values) do -- the 'values' here are the keys of the dictionnary
				local set1, set2 = ml.divideset(rows, col, value) -- define set1 and set2 as the 2 children set of a division

				-- Information gain
				local p = tonumber(#set1/#rows) -- p is the size of a child set relative to its parent
				local gain = current_score-p*scoref(set1)-(1-p)*scoref(set2) -- cf. formula information gain
				if gain > best_gain and #set1 > 0 and #set2 > 0 then -- set must not be empty
					best_gain = gain
					best_criteria[1] = col
					best_criteria[2] = value
					best_sets[1] = set1
					best_sets[2] = set2
				end
			end
		end
	end

	-- Create the sub branches
	if best_gain > 0 then
		local trueBranch = ml.buildtree(best_sets[1])
		local falseBranch = ml.buildtree(best_sets[2])
		return ml.decisionnode.create(best_criteria[1], best_criteria[2], nil, trueBranch, falseBranch)
	else
		return ml.decisionnode.create(nil, nil, ml.uniquecounts(rows), nil, nil)
	end
end

return ml
