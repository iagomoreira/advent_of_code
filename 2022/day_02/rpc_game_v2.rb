class Choice
  attr_reader :name, :choice_code

  def initialize(choice_code)
    @choice_code = choice_code
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
    {
      "A" => :rock,
      "B" => :paper,
      "C" => :scissor
    }[choice_code]
  end
end

class Round
  def initialize(round)
    codes = round.split(" ")
    @choice_a = Choice.new(codes[0])
    @strategy = codes[1]
    @choice_b = strategy_choice
  end

  def result
    {
      player_a: calculate_points(@choice_a, @choice_b),
      player_b: calculate_points(@choice_b, @choice_a)
    }
  end

  private
  def strategy_choice
    if @strategy == "Y"
      Choice.new(@choice_a.choice_code)
    elsif @strategy == "X"
      Choice.new(rules[@choice_a.choice_code])
    else
      Choice.new(rules.invert[@choice_a.choice_code])
    end
  end

  def calculate_points(choice_a, choice_b)
    if choice_a.choice_code == choice_b.choice_code
      3 + choice_a.value
    elsif rules[choice_a.choice_code] == choice_b.choice_code
      6 + choice_a.value
    else
      0 + choice_a.value
    end
  end

  def rules
    {
      "A" => "C",
      "B" => "A",
      "C" => "B"
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
