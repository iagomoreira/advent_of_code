class JunktionNetwork
  attr_reader :boxes
  def initialize(boxes)
    @boxes = boxes
  end

  def sorted_boxes
    @sorted_boxes ||= @boxes.combination(2).map {|box1, box2| [box1.id, box2.id, box1.shortest_distance_to(box2)]}
      .sort_by {|_, _, distance| distance }
      .map { |box1_id, box2_id, _| Set.new([box1_id, box2_id]) }
      .lazy
  end

  def merge_circuits(size)
    box_sets = sorted_boxes.take(size)
    merged = true
    result = nil

    loop do
      break unless merged
      merged = false
      result = []
      box_sets.each do |set|
        box = result.find { |a| set.any? { |b| a.include?(b) } }
        if box
          box.merge(set)
          merged = true
        else
          result << set
        end
      end
      box_sets = result
    end

    result
  end

  def largest_circuits_value(size, n)
    merge_circuits(size).map(&:size).max(n).reduce(:*)
  end
end
