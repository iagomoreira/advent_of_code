def find_freespace(disk_map, index, limit, size)
  start_index = nil
  (index..limit).each do |i|
    start_index = i if disk_map[i].nil? && start_index.nil?
    start_index = nil unless disk_map[i].nil?
    next if start_index.nil?
    return start_index if i - start_index >= size
  end
  nil
end

def find_file_block(disk_map, start_index, finish)
  return if start_index.negative?

  previous_index = start_index - 1
  return find_file_block(disk_map, previous_index, previous_index) if disk_map[start_index].nil?

  return [start_index, finish] if disk_map[previous_index] != disk_map[finish]

  find_file_block(disk_map, previous_index, finish)
end

def find_first_freespace(disk_map, idx)
  (idx..(disk_map.size - 1)).each do |i|
    return i if disk_map[i].nil?
  end
end

def reallocate_disk_map_by_blocks(disk_map)
  finish = disk_map.size - 1
  start_index = 0
  while finish >= 0
    file_block_start, file_block_end = find_file_block(disk_map, finish, finish)
    break if file_block_start.nil?

    move_size = file_block_end - file_block_start
    finish = file_block_start - 1
    free_space = find_freespace(disk_map, start_index, finish, move_size)
    next if free_space.nil?

    (0..move_size).each do |i|
      disk_map[free_space + i] = disk_map[file_block_start + i]
      disk_map[file_block_start + i] = nil
    end
    start_index = find_first_freespace(disk_map, start_index)
  end
end

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

reallocate_disk_map_by_blocks(disk_map)

checksum = disk_map.each.with_index.sum do |val, i|
  next 0 if val.nil?

  i * val
end
puts checksum
