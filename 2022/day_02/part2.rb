require_relative 'rpc_game_v2'

game = Game.new(File.readlines(ARGV[0]))

p game.result[:player_b]

