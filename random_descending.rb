expected = height = 0
line = gets

until line.empty?
	case line[0]
		when 40
			height += 1
			line = line[1..-1].lstrip
		when 41
			height -= 1
			line = line[1..-1].lstrip
		else
			expected += 0.5**height * line.to_i
			line.gsub!(/^\s*-?\d+\s*/,'')
	end
end

puts "%.2f" % expected
