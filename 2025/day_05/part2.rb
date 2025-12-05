ranges = []

def combine_ranges(ranges)
  combined = [ranges.shift]

  ranges.each do |current_range|
    last_range = combined.last
    if current_range.first <= last_range.last + 1
      combined[-1] = (last_range.first..[last_range.last, current_range.last].max)
    else
      combined << current_range
    end
  end
  combined
end

ARGF.readlines.each do |line|
  line = line.chomp
  break if line.empty?

  match_data = line.match(/(\d+)-(\d+)/)
  if match_data
    ranges << [match_data[1].to_i,match_data[2].to_i]
  end
end

ranges.sort!

combined_ranges = combine_ranges(ranges)

puts combined_ranges.sum { |range| range.last - range.first + 1 }
