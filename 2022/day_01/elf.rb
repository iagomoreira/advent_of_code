class Elf
  include Comparable

  attr_reader :food_items

  def initialize(food_items)
    @food_items = food_items.map(&:to_i)
  end

  def total_calories
    food_items.sum
  end

  def <=> (elf)
    total_calories <=> elf.total_calories
  end
end
