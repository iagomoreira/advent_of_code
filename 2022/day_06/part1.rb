def find_marker_and_position(datastream)
  for i in (4..datastream.size)
    marker_candidate = datastream[i-4,4].chars
    if marker_candidate == marker_candidate.uniq
      return {marker: marker_candidate.last, position: i}
      break
    end
  end
end
datastream = File.readlines(ARGV[0]).first.chomp
result = find_marker_and_position(datastream)
p result[:position]
