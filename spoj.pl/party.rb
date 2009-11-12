def input
	gets.split(' ').map { |a| a.to_i }
end

def get_parties(n)
	@parties = [[0,0]]
	n.times do |i|
		@parties[i+1] = input
	end
	@parties = @parties.sort do |a,b|
		a[0] <=> b[0]
	end
end

def optimal(i, w)
	return 0 if i <= 0 or w <= 0

	@table    ||= []
	@table[i] ||= []
	
	return @table[i][w] unless @table[i][w].nil?

	co, fo = @parties[i]
	c1 = optimal(i - 1, w)
	c2 = optimal(i - 1, w - co)

	if (w < co)
		@table[i][w] = c1
	else
		@table[i][w] = [fo + c2, c1].max
	end

	return @table[i][w]
end

def backtrack(i, w)
	return 0 if i <= 0 or w <= 0

	co, fo = @parties[i]
	c1 = optimal(i - 1, w)
	c2 = optimal(i - 1, w - co)

	return backtrack(i - 1, w) if co > w

	if c1 < c2 + fo
		return co + backtrack(i - 1, w - co)
	else
		return backtrack(i - 1, w)
	end
end

while true
	w, n = input
	next if w.nil? or n.nil?
	exit 0 if w == 0 and n == 0

	@parties = nil
	@table   = nil
	get_parties(n)

	o = optimal(n, w)
	b = backtrack(n, w)

	puts "%d %d" % [b, o]
end
