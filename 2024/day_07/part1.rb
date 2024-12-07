def valid_operation? operand_list, test_value
  values = [operand_list.first]
  operand_list.drop(1).each do |operand|
    values = values.flat_map {|n| [n + operand, n * operand] }
  end

  values.include? test_value
end

input = ARGF.readlines(chomp: true).to_h do |line|
  test_value, operand = line.split(': ')
  operand_list = operand.split.map(&:to_i)
  [test_value.to_i, operand_list]
end

result = 0
input.each do |test_value, operand_list|
  result += test_value if valid_operation?(operand_list, test_value)
end

puts result
