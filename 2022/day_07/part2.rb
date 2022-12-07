require_relative 'aoc_cli_parser'

def get_all_children(directory)
  dirs = directory.children.map {|child| get_all_children(child) if child.is_a? Directory}.compact
  dirs << directory unless directory.name == "/"
  dirs.flatten
end

terminal_output = File.readlines(ARGV[0], chomp: true)
terminal = Terminal.new(terminal_output)
terminal.execute

SYSTEM_SIZE = 70000000
REQUIRED_SIZE = 30000000
FREE_SIZE = SYSTEM_SIZE - terminal.root_dir.size
SIZE_TO_DELETE = REQUIRED_SIZE - FREE_SIZE

p get_all_children(terminal.root_dir).sort_by(&:size).select { |c| c.size >= SIZE_TO_DELETE }.first.size
