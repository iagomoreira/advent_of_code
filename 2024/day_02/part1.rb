class Report
  POSITIVE_SAFETY_THRESHOLD = (1..3)
  NEGATIVE_SAFETY_THRESHOLD = (-3..-1)

  attr_reader :levels, :type

  def initialize(levels)
    @levels = levels
  end

  def is_safe?
    level_increases = levels.each_cons(2).map {|level1, level2| level1-level2 }

    level_increases.all? {|l| POSITIVE_SAFETY_THRESHOLD.include?(l) } || level_increases.all? {|l| NEGATIVE_SAFETY_THRESHOLD.include?(l) }
  end
end

reports = File.readlines(ARGV[0]).map do |line|
  Report.new(line.split.map(&:to_i))
end

puts reports.count {|report| report.is_safe? }
