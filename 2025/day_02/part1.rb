id_ranges = ARGF.read.chomp.split(',').map {|range| Range.new(*range.split('-').map(&:to_i)) }

invalid_ids = []

def invalid_id?(id)
  first = id[0, id.length/2]
  last = id[id.length/2, id.length]
  first == last
end

id_ranges.each do |range|
  range.to_a.each do |id|
    invalid_ids << id if invalid_id?(id.to_s)
  end
end

puts invalid_ids.sum
