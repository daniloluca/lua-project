local ml = {}

function log(x)
	if x == 0 then
		return 0
	end
	return math.log(x)/math.log(2)
end

function concat(a, b)
	if b ~= nil then
		for i=1, #b do
			a[i][#a[i]+1] = b[i]
		end
	end
	return a
end

function entropy(set)
	local entr = 0
	for key, value in pairs(set) do
		entr = entr + ((-value)*log(value))
	end
	return entr
end

function info(set)
	if type(set[1]) == "table" then
		local _set = {}
		local size = 0
		for ki, vi in pairs(set) do
			_set[#_set+1] = {
				entr = info(vi),
				size = 0
			}
			for kj, vj in pairs(vi) do
				_set[#_set].size = _set[#_set].size + vj
			end
			size = size + _set[#_set].size
		end

		local entr = 0
		for k, v in pairs(_set) do
			entr = entr + ((v.size/size)*v.entr)
		end

		return entr
	else
		local size = 0
		for key, value in pairs(set) do
			size = size + value
		end

		local _set = {}
		for key, value in pairs(set) do
			_set[#_set+1] = value/size
		end
		return entropy(_set)
	end
end

function divide(node, branch, cond)
	local split
	if type(cond) == "number" then
		split = function(set)
			return set[branch] >= cond
		end
	elseif type(cond) == "string" then
		split = function(set)
			return set[branch] == cond
		end
	end

	local sett = {}
	local setf = {}
	for key, value in pairs(node) do
		if split(value) then
			sett[#sett+1] = value
		else
			setf[#setf+1] = value
		end
	end

	return sett, setf
end

function gain(s, a)
	return info(s) - info(a)
end

function getSet(rows)
	local set = {}
	for k, row in pairs(rows) do
		if set[row[#row]] == nil then
			set[row[#row]] = 0
		end
		set[row[#row]] = set[row[#row]] + 1
	end

	local _set = {}
	for k, v in pairs(set) do
		_set[#_set+1] = v
		print(v);
	end

	return _set
end

function build(rows)

	print(info({9, 5}))
	print(info({{3, 2}, {4, 0}, {2, 3}}))
	print(gain({9, 5}, {{3, 2}, {4, 0}, {2, 3}}))


	local best_gain = 0
  	local best_criteria
  	local best_sets = {}

	for col=1, #rows[1]-1 do

		local column_values = {}
		for k, row in pairs(rows) do
			column_values[row[col]] = 1
		end

		for k, value in pairs(column_values) do
			local set1, set2 = divide(rows, col, value)

			local p = float(len(set1))/len(rows)
			local gain = current_score-p*scoref(set1)-(1-p)*scoref(set2)
		end
	end

	return features
end

function ml.tree(features, labels)
	return build(concat(features, labels))
end

return ml
