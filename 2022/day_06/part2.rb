def find_marker_and_position(datastream)
  for i in (14..datastream.size)
    marker_candidate = datastream[i-14,14].chars
    if marker_candidate == marker_candidate.uniq
      return {marker: marker_candidate.last, position: i}
      break
    end
  end
end
datastream = File.readlines(ARGV[0]).first.chomp
result = find_marker_and_position(datastream)
p result[:position]
