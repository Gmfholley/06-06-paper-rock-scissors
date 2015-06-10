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
      new_game = PaperRockScissorsGame.new()
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

new_game = PaperRockScissorsGame.new()
user_game = GameDriver.new(game: new_game)

user_game.set_up_enough_players
user_game.play_game

puts "\nNow playing a game with 70 people."

all_70_players = []
(1..70).each do |c|
  a = ComputerPlayer.new(c.to_s)
  all_70_players.push(a)
end

seventy_person_game = PaperRockScissorsGame.new()
seventy_driver = GameDriver.new(game: seventy_person_game)

seventy_driver.set_up_these_players_plus_any_more_required(all_70_players)
seventy_driver.play_game

# now plays a tournament with 70 people

all_players = all_70_players
round = 1
while all_players.length > 1
  puts "\nPlaying round #{round} in the tournament!"
  new_tournament = TournamentRound.new(all_players)
  brackets = new_tournament.get_brackets

  #play each bracket
  brackets.each_with_index do |players_for_game, index|
    puts "Bracket:\t#{index + 1}"
    winners = players_for_game

    # loop until you get a winner for the bracket
    # play_game may take a few games if there is a tie
    while winners.length > 1
      new_game = PaperRockScissorsGame.new()
      g_driver = GameDriver.new(game: new_game)
      g_driver.set_up_these_players_plus_any_more_required(players_for_game)
      winners = g_driver.play_game
    end
    #remove loser from all_players

    players_for_game.delete(winners[0])
    all_players.delete(players_for_game[0])
    
  end
  round += 1
end



/#
cplayer = ComputerPlayer.new("computer")
cplayer.increment_score
play = ["rock", "paper", "scissors"]

this = Player.new("wendy")
this.set_valid_move(play)

cplayer.set_valid_move(play)
binding.pry #/