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

function getLabels(rows)
	local set = {}
	for k, row in pairs(rows) do
		if set[row[#row]] == nil then
			set[row[#row]] = 0
		end
		set[row[#row]] = set[row[#row]] + 1
	end
	return set
end

function quantify(rows)
	local labels = getLabels(rows)
	local set = {}
	for k, v in pairs(labels) do
		set[#set+1] = v
	end
	return set
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

function build(rows)
	if #rows == 0 then
		return {}
	end

	local current_score = info(quantify(rows))

	local best_gain = 0
  	local best_criteria = {}
  	local best_sets = {}

	for col=1, #rows[1]-1 do

		local column_values = {}
		for k, row in pairs(rows) do
			column_values[row[col]] = 1
		end

		for key, value in pairs(column_values) do
			local set1, set2 = divide(rows, col, key)

			local p = #set1/#rows
			local gain = current_score-p*info(quantify(set1))-(1-p)*info(quantify(set2))

			if gain > best_gain and #set1 > 0 and #set2 > 0 then
				best_gain = gain
				best_criteria = {col, key}
				best_sets = {set1, set2}
			end
		end
	end

	if best_gain > 0 then
		return {
			col = best_criteria[1],
			value = best_criteria[2],
			tb = build(best_sets[1]),
			fb = build(best_sets[2])
		}
	else
		return {
			results = getLabels(rows)
		}
	end
end

function ml.tree(features, labels)
	return build(concat(features, labels))
end

function ml.run(tree, features)
	if tree.results ~= nil then
		return tree.results
	else
		local v = features[tree.col]
		local branch = {}
		if type(v) == "number" then
			if v >= tree.value then
				branch = tree.tb
			else
				branch = tree.fb
			end
		else
			if v == tree.value then
				branch = tree.tb
			else
				branch = tree.fb
			end
		end
		return ml.run(branch, features)
	end
end

return ml
