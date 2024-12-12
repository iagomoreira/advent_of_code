require_relative '../../utils/bidimensional_array'

class PlantRegionPriceCalculator
  DIRECTIONS = %i(left right up down)

  class PlantRegion
    attr_reader :plants, :type
    def initialize(type)
      @type = type
      @plants = []
    end

    def add_plant(plant)
      @plants << plant if plant == @type
    end

    def area
      @plants.size
    end

    def perimeter
      @plants.map do |plant|
        adjacent_plants = DIRECTIONS.map {|direction| plant.adjacent_element_in_direction(direction) }
        adjacent_plants.count {|adj_plant| adj_plant&.value != plant.value}
      end.sum
    end

    def price
      area * perimeter
    end
  end

  def initialize(grid)
    @grid = BidimensionalArray.new(grid)
    @visited_positions = []
    @plant_regions = []
  end

  def find_plant_regions
    current_plant_region_type = nil

    @grid.each do |row|
      row.each do |plant|
        next if @visited_positions.include? plant.position

        current_plant_region_type = plant.value
        plant_region = PlantRegion.new(current_plant_region_type)
        lookup_plant_region(plant, plant_region)
        @plant_regions << plant_region
      end
    end

    @plant_regions
  end

  def lookup_plant_region(plant, plant_region)
    return if plant.nil? || plant.value != plant_region.type
    return if @visited_positions.include?(plant.position)

    plant_region.add_plant(plant)
    @visited_positions << plant.position

    DIRECTIONS.each do |direction|
      next_plant = plant.adjacent_element_in_direction(direction)
      lookup_plant_region(next_plant, plant_region)
    end
  end

  def price
    find_plant_regions if @plant_regions.empty?

    @plant_regions.sum(&:price)
  end
end

input = ARGF.readlines(chomp: true).map(&:chars)

calculator = PlantRegionPriceCalculator.new(input)

start_time = Time.now

result = calculator.price

end_time = Time.now

puts "Result #{result} in #{end_time - start_time} seconds"
