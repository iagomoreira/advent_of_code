input = ARGF.readlines(chomp: true)

joltage_sum = 0

def find_max_and_index(str)
  value = str.chars.max
  index = str.index(value)

  return value, index
end

def build_joltage(battery_bank, size)
  joltage = []
  index = -1
  accumulated_index = 0

  size.times do |i|
    accumulated_index += index + 1
    value, index = find_max_and_index(battery_bank[accumulated_index..-size+i])
    joltage << value
  end
  joltage.join

end

input.each do |battery_bank|
  joltage = build_joltage(battery_bank, 12)

  joltage_sum += joltage.to_i
end

puts joltage_sum
