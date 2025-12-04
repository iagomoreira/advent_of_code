require_relative '../../utils/bidimensional_array'

input = ARGF.readlines.map {|line| line.chomp.chars }
matrix = BidimensionalArray.new(input)

removable_rolls_count = 0

loop do
  previous_count = removable_rolls_count
  matrix.each_with_index do |row, row_index|
    row.each_with_index do |element, col_index|
      adjacent_roll_count = element.adjacent_elements.count { |adjacent| adjacent && adjacent.value == '@' }
      if element.value == '@' && adjacent_roll_count < 4
        removable_rolls_count += 1
        element.value = '.'
      end
    end
  end
  break if previous_count == removable_rolls_count
end

puts removable_rolls_count
