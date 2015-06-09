require_relative "game.rb"
require_relative "game_driver.rb"
require_relative "tournament.rb"



all_players = []

#create players for the tournament

('a'..'g').each do |c|
  all_players.push(ComputerPlayer.new(c))
end


# all_players holds current players
# when length of all_players is 1, you have a winner

while all_players.length > 1
  puts "\nPlaying a new round in the tournament!"
  new_tournament = TournamentRound.new(all_players)
  brackets = new_tournament.get_brackets

  #play each bracket
  brackets.each_with_index do |players_for_game, index|
    puts "Round:\t#{index + 1}"
    winners = players_for_game

    # loop until you get a winner for the bracket
    # play_game may take a few games if there is a tie
    while winners.length > 1
      args = {}
      new_game = PaperRockScissorsGame.new(args)
      g_driver = GameDriver.new(game: new_game)
      g_driver.set_up_these_players_plus_any_more_required(players_for_game)
      winners = g_driver.play_game
    end
    #remove loser from all_players

    players_for_game.delete(winners[0])
    all_players.delete(players_for_game[0])
  end
  
end

puts "The ultimate winner is #{all_players[0].name}"
puts "\Now letting the user play."

args = {}
new_game = PaperRockScissorsGame.new(args)
user_game = GameDriver.new(game: new_game)

user_game.set_up_enough_players
user_game.play_game

/#
cplayer = ComputerPlayer.new("computer")
cplayer.increment_score
play = ["rock", "paper", "scissors"]

this = Player.new("wendy")
this.set_valid_move(play)

cplayer.set_valid_move(play)
binding.pry #/