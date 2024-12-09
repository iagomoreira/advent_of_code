input = ARGF.readline(chomp: true).chars.map(&:to_i)

disk_map = []

input.each_with_index do |value, i|
  id = i / 2
  if i % 2 == 0
    value.times { disk_map << id }
  else
    value.times { disk_map << nil }
  end
end

def reallocate_disk_map_and_checksum(disk_map)
  i = 0
  finish = disk_map.size - 1
  checksum = 0
  while i < finish
    if disk_map[i].nil?
      finish -= 1 while disk_map[finish].nil? && finish > i
      disk_map[i] = disk_map[finish]
      disk_map[finish] = nil
    end
    id = disk_map[i]
    checksum += i * id unless id.nil?
    i += 1
  end

  checksum
end


puts reallocate_disk_map_and_checksum(disk_map)
