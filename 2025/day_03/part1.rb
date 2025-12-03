input = ARGF.readlines(chomp: true)

joltage_sum = 0

def find_max_and_index(str)
  value = str.chars.max
  index = str.index(value)

  return value, index
end

input.each do |battery_bank|
  largest_before_last, index = find_max_and_index(battery_bank[0..-2])
  second_largest, _ = find_max_and_index(battery_bank[index+1..-1])

  joltage_sum += (largest_before_last+ second_largest).to_i
end

puts joltage_sum
