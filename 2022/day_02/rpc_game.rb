class Choice
  attr_reader :name

  def initialize(choice_code)
    @name = code_mapper(choice_code)
  end

  def value
    values_map[name]
  end

  private

  def values_map
    {
      rock: 1,
      paper: 2,
      scissor: 3
    }
  end

  def code_mapper(choice_code)
    case choice_code
    when "A", "X"
      :rock
    when "B", "Y"
      :paper
    when "C", "Z"
      :scissor
    end
  end
end

class Round
  def initialize(round)
    @choice_a, @choice_b = round.split(" ").map {|choice| Choice.new(choice)}
  end

  def result
    {
      player_a: calculate_points(@choice_a, @choice_b),
      player_b: calculate_points(@choice_b, @choice_a)
    }
  end

  private
  def calculate_points(choice_a, choice_b)
    if choice_a.name == choice_b.name
      3 + choice_a.value
    elsif rules[choice_a.name] == choice_b.name
      6 + choice_a.value
    else
      0 + choice_a.value
    end
  end

  def rules
    {
      rock: :scissor,
      paper: :rock,
      scissor: :paper
    }
  end
end

class Game
  def initialize(game_rounds)
    @rounds = game_rounds.map do |round|
      Round.new(round.chomp)
    end
  end

  def result
    {
      player_a: @rounds.sum {|round| round.result[:player_a]},
      player_b: @rounds.sum {|round| round.result[:player_b]}
    }
  end
end
