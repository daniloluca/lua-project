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

return ml
