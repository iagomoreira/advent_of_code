id_ranges = ARGF.read.chomp.split(',').map {|range| Range.new(*range.split('-').map(&:to_i)) }

invalid_ids = []

def invalid_id?(id)
  is_invalid = false

  (id.size/2).times do |i|
    substr = id[0..i]
    factor = id.size / substr.size
    is_invalid = substr * factor == id
    break if is_invalid
  end

  is_invalid
end

id_ranges.each do |range|
  range.to_a.each do |id|
    invalid_ids << id if invalid_id?(id.to_s)
  end
end

puts invalid_ids.sum
