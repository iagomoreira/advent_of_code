class FileInfo
  attr_reader :name, :size
  def initialize(name, size)
    @name = name
    @size = size
  end
end

class Directory
  attr_accessor :name, :children, :parent

  def initialize(name, parent)
    @name = name
    @parent = parent
    @children = []
  end

  def size
    children.sum {|child| child.size }
  end
end

class Terminal
  attr_reader :root_dir, :current_dir
  def initialize(instructions)
    @instructions = instructions
    @root_dir = Directory.new("/", nil)
    @current_dir = nil
  end

  def execute
    @instructions.each {|instruction| parse(instruction) }
  end

  private
  def parse(line)
    case line.split
    in ["$", "cd", "/"]
      @current_dir = @root_dir
    in ["$", "cd", ".."]
      @current_dir = @current_dir.parent
    in ["$", "cd", dir_name]
      child = @current_dir.children.find {|child| child.name == dir_name }
      if child.nil?
        child = Directory.new(dir_name, @current_dir)
        @current_dir.children.push(child)
      end
      @current_dir = child
    in ["dir", dir_name]
      # NOOP
    in [size, file_name] if size.match?(/^\d+$/)
      new_file = FileInfo.new(file_name, size.to_i)
      @current_dir.children.push(new_file)
    else
    end
  end
end
