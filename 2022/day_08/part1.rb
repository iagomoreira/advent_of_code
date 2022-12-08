trees = File.readlines(ARGV[0], chomp: true).map {|line| line.split('').flat_map(&:to_i)}

# Starts with the trees in the edge as visible
visible_trees = (trees.size * trees.size) - ((trees.size-2) * (trees.size-2))

for i in (1..trees.size-2) do
  for j in (1..trees.size-2) do
    tree_size = trees[i][j]
    top_trees = (0..i-1).map{|n| trees[n][j] }
    left_trees = (0..j-1).map{|n| trees[i][n] }
    right_trees = (j+1..trees.size-1).map{|n| trees[i][n] }
    bottom_trees = (i+1..trees.size-1).map{|n| trees[n][j] }
    trees_to_the_edge = [top_trees, left_trees, right_trees, bottom_trees]

    visible_trees += 1 if trees_to_the_edge.any? {|trees_set| trees_set.all? {|tree| tree < tree_size} }
  end
end
puts visible_trees
