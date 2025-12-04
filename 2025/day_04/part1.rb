require_relative '../../utils/bidimensional_array'

input = ARGF.readlines.map {|line| line.chomp.chars }
matrix = BidimensionalArray.new(input)

accessible_rolls = []

matrix.each_with_index do |row, row_index|
  row.each_with_index do |element, col_index|
    adjacent_roll_count = element.adjacent_elements.count { |adjacent| adjacent && adjacent.value == '@' }
    if element.value == '@' && adjacent_roll_count < 4
      accessible_rolls << [row_index, col_index]
    end
  end
end

puts accessible_rolls.size
