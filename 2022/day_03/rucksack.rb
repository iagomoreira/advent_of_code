require "active_support/core_ext/array/grouping"
require_relative "item_helper"

class Rucksack
  include ItemHelper
  attr_reader :items, :compartment_1, :compartment_2
  def initialize(items)
    @items = items.chars
    @compartment_1, @compartment_2 = items.chars.in_groups(2)
  end

  def repeated_items
    @repeated_items ||= @compartment_1.select do |item|
      @compartment_2.include? item
    end.uniq
  end

  def repeated_item_values
    repeated_items.sum do |repeated_item|
      item_value(repeated_item)
    end
  end
end
