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

function ml.devideset(rows, column, value)
	local split_function;
	if type(value) == "number" then
		split_function = function(row)
			return row[column] >= value
		end
	elseif type(value) == "string" then
		split_function = function(row)
			return row[column] == value
		end
	end

	local set1 = {}
	local set2 = {}
	for i=1, #rows, 1 do
		if split_function(rows[i]) then
			set1[#set1+1] = rows[i]
		else
			set2[#set2+1] = rows[i]
		end
	end

	return set1, set2
end


return ml
