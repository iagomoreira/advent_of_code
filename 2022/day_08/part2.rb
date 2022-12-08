trees = File.readlines(ARGV[0], chomp: true).map {|line| line.split('').flat_map(&:to_i)}

# Starts with the trees in the edge as visible
scenic_score = []

for i in (1..trees.size-2) do
  for j in (1..trees.size-2) do
    tree_size = trees[i][j]
    top_trees = (0..i-1).map{|n| trees[n][j] }.reverse
    left_trees = (0..j-1).map{|n| trees[i][n] }.reverse
    right_trees = (j+1..trees.size-1).map{|n| trees[i][n] }
    bottom_trees = (i+1..trees.size-1).map{|n| trees[n][j] }
    trees_to_the_edge = [top_trees, left_trees, bottom_trees, right_trees]

    scenic_score << trees_to_the_edge.map do |trees_in_direction|
      direction_score = 0
      trees_in_direction.each do |tree|
        direction_score += 1
        break unless tree < trees[i][j]
      end

      direction_score
    end.reduce(:*)
  end
end

puts scenic_score.max
