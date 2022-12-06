require_relative "item_helper"

class ElfGroup
  include ItemHelper

  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def badge
    @badge ||= (@rucksacks[0].items & @rucksacks[1].items & @rucksacks[2].items).first
  end

  def badge_value
    item_value(badge)
  end
end

