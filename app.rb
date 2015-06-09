require_relative "game.rb"
require_relative "game_driver.rb"
require_relative "tournament.rb"



all_players = []

('a'..'g').each do |c|
  all_players.push(ComputerPlayer.new(c))
end

while all_players.length > 1
  new_tournament = Tournament.new(all_players)
  brackets = new_tournament.get_brackets
  #play each bracket
  brackets.each do |players_for_game|
    winners = players_for_game
    # loop until you get a winner for the bracket
    while winners.length > 1
      args = {}
      new_game = PaperRockScissorsGame.new(args)
      g_driver = GameDriver.new(game: new_game)
      g_driver.set_up_these_players_plus_any_more_required(players_for_game)
      winners = g_driver.play_game  
    end
    #remove loser from all_players
    binding.pry
    players_for_game.delete(winners[0])
    all_players.delete(players_for_game[0])
  end
  puts "Playing a new round in the tournament!"
end

puts "The ultimate winner is #{all_players}"

# puts "\n\nNow testing by setting up my own computer players."
#
# deek = ComputerPlayer.new("Deek - a computer")
#
# second_game = PaperRockScissorsGame.new(args)
# g_drive = GameDriver.new(game: second_game)
#
# g_drive.set_up_these_players_plus_any_more_required([deek])
# g_drive.play_game



/#
cplayer = ComputerPlayer.new("computer")
cplayer.increment_score
play = ["rock", "paper", "scissors"]

this = Player.new("wendy")
this.set_valid_move(play)

cplayer.set_valid_move(play)
binding.pry #/