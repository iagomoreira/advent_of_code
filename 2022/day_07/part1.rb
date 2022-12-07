require_relative 'aoc_cli_parser'

SIZE_THRESHOLD = 100_000

def find_directories_below_threshold(directory)
  dirs = []

  dirs << directory if directory.size < SIZE_THRESHOLD
  dirs << directory.children.map { |child| find_directories_below_threshold(child) if child.is_a? Directory}.compact

  dirs
end

terminal_output = File.readlines(ARGV[0], chomp: true)
terminal = Terminal.new(terminal_output)
terminal.execute

puts find_directories_below_threshold(terminal.root_dir).flatten.sum { |c| c.size }
