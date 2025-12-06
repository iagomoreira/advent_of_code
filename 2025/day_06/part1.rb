input = ARGF.readlines.map { |line| line.chomp.split(/\s+/).map{|e| e.empty? ? nil : e }.compact }

results = 0

input[0].size.times do |i|
  column = input.map {|row| row[i] }
  *values, op = column
  results += eval(values.join(op))
end

puts results
