lines = File.readlines(ARGV[0]).map(&:strip)

class EngineElement
  attr_accessor :value, :position, :type, :adjacent_numbers
  def initialize(value, position)
    @value = value
    @position = position
    @adjacent_numbers = []
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
      line.scan(/\d+|\*/) do |c|
        values_and_indexes << [c, $~.offset(0)[0]]
      end
      values_and_indexes.map do |value, index|
        EngineElement.new(value, [i,index])
      end
    end
  end

  def gear_ratios
    find_numbers.each do |number|
      find_symbols.each do |symbol|
        symbol.adjacent_numbers << number.value.to_i if number.adjacent_positions.include?(symbol.position)
      end
    end

    find_symbols.select do |symbol|
      symbol.adjacent_numbers.count == 2
    end.sum do |gear|
      gear.adjacent_numbers.reduce(:*)
    end
  end

  def symbol_positions
    find_symbols.map(&:position)
  end

  def find_symbols
    @symbols ||= engine_elements.select(&:symbol?)
  end

  def find_numbers
    @numbers ||= engine_elements.select(&:number?)
  end
end

engine = Engine.new(lines)
puts engine.gear_ratios
