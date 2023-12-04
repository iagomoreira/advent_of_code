lines = File.readlines(ARGV[0]).map(&:strip)

class EngineElement
  attr_accessor :value, :position, :type
  def initialize(value, position)
    @value = value
    @position = position
    @type = value.match?(/\d+/) ? :engine_number : :engine_symbol
  end

  def adjacent_positions
    x, y = @position
    adjacent_positions = [
      [x-1, y-1],
      [x-1, y + @value.size],
      [x, y-1],
      [x, y + @value.size],
      [x+1, y-1],
      [x+1, y + @value.size],
    ]

    @value.size.times do |i|
      adjacent_positions << [x-1, y+i]
      adjacent_positions << [x+1, y+i]
    end

    adjacent_positions.uniq
  end

  def symbol?
    @type == :engine_symbol
  end

  def number?
    @type == :engine_number
  end
end

class Engine
  def initialize(lines)
    @lines = lines
  end

  def engine_elements
    @engine_elements ||= @lines.each_with_index.flat_map do |line, i|
      values_and_indexes = []
      line.scan(/\d+|[^0-9.]/) do |c|
        values_and_indexes << [c, $~.offset(0)[0]]
      end
      values_and_indexes.map do |value, index|
        EngineElement.new(value, [i,index])
      end
    end
  end

  def find_part_numbers
    engine_elements.select do |element|
      element.number? && element.adjacent_positions.any? {|adj| symbol_positions.include? adj }
    end
  end

  def symbol_positions
    find_symbols.map(&:position)
  end

  def find_symbols
    engine_elements.select(&:symbol?)
  end

  def find_numbers
    engine_elements.select(&:number?)
  end
end

engine = Engine.new(lines)
puts engine.find_part_numbers.sum {|number| number.value.to_i }

# symbol_positions = []

# input_lines.each_with_index do |line, i|
#   line.chars.each_with_index do |char, j|
#     symbol_positions << [i,j] if char =~ /[^0-9.]/
#   end
# end

# p symbol_positions
