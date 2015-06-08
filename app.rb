require_relative "game.rb"
require_relative "game_driver.rb"

args = {}
new_game = PaperRockScissorsGame.new(args)
g_driver = GameDriver.new(game: new_game)
g_driver.set_up_enough_players
g_driver.play_game
g_driver.play_best_of_game_set

puts "\n\nNow testing by setting up my own computer players."

deek = ComputerPlayer.new("Deek - a computer")

second_game = PaperRockScissorsGame.new(args)
g_drive = GameDriver.new(game: second_game)

g_drive.set_up_these_players_plus_any_more_required([deek])
g_drive.play_game

/#
cplayer = ComputerPlayer.new("computer")
cplayer.increment_score
play = ["rock", "paper", "scissors"]

this = Player.new("wendy")
this.set_valid_move(play)

cplayer.set_valid_move(play)
binding.pry #/