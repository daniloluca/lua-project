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

return ml
