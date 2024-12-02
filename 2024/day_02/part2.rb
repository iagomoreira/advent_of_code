class Report
  POSITIVE_SAFETY_THRESHOLD = (1..3)
  NEGATIVE_SAFETY_THRESHOLD = (-3..-1)

  attr_reader :levels, :type

  def initialize(levels)
    @levels = levels
    @unsafe_levels = 0
    @dampened_problems = 0
  end

  def is_safe?
    is_safe = valid_levels?(levels)

    if !is_safe
      return valid_dampened_levels?
    end

    is_safe
  end

  def valid_dampened_levels?
    (0..levels.size).map {|i| levels.dup.tap {|dampened_level| dampened_level.delete_at(i) } }.any? do |dl|
      valid_levels?(dl)
    end
  end

  def valid_levels?(levels)
    level_increases = levels.each_cons(2).map {|level1, level2| level1-level2 }

    level_increases.all? {|l| POSITIVE_SAFETY_THRESHOLD.include?(l) } || level_increases.all? {|l| NEGATIVE_SAFETY_THRESHOLD.include?(l) }
  end
end

reports = File.readlines(ARGV[0]).map do |line|
  Report.new(line.split.map(&:to_i))
end

puts reports.count {|report| report.is_safe? }
