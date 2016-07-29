local ml = {}

function log(x)
	if x == 0 then
		return 0
	end
	return math.log(x)/math.log(2)
end

function entropy(set)
	local entr = 0
	for key, value in pairs(set) do
		entr = entr + ((-value)*log(value))
	end
	return entr
end

function single(set)
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

function multiple(sets)
	local _sets = {}
	local size = 0
	for ki, vi in pairs(sets) do
		_sets[#_sets+1] = {
			entr = single(vi),
			size = 0
		}
		for kj, vj in pairs(vi) do
			_sets[#_sets].size = _sets[#_sets].size + vj
		end
		size = size + _sets[#_sets].size
	end

	local entr = 0
	for k, v in pairs(_sets) do
		entr = entr + ((v.size/size)*v.entr)
	end

	return entr
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

function gain(s, m)
	return single(s) - multiple(m)
end

function ml.parse(features, labels)
	local data = {}
	for i=1, #features[1] do
		data[i] = {}
		for j=1, #features do
			if data[i][features[j][i]] == nil then
				data[i][features[j][i]] = {}
			end
			data[i][features[j][i]][#data[i][features[j][i]]+1] = labels[j]
		end
	end
	return data
end

return ml
