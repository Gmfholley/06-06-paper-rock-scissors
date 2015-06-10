require_relative "game.rb"
require_relative "computer_player.rb"

class GameDriver
  
  attr_reader :game, :best_of
  
  # options - Hash
  #           :game     -  Game object
  #           :best_of  -  optional Integer of number of games
  def initialize(args)
    @game = args[:game]
    if args[:best_of].nil?
      set_best_of
    else
      set_best_of(args[:best_of])
    end
  end    
  
  # user can send an array of players to add and the game driver will set up any more required in additon
  #
  # players - Array of players
  #
  # returns game
  def set_up_these_players_plus_any_more_required(players)
    players.each do |player|
      game.add_player_to_players(player)
    end
    add_computer_players_if_not_enough_humans
    game
  end
  
  # gets enough players for game
  #
  # returns game
  def set_up_enough_players
    get_user_players
    add_computer_players_if_not_enough_humans
    game
  end
  
  # plays a game & displays the score
  #
  # returns winners
  def play_game
    get_player_moves
    winners = game.play_game_with_current_moves
    publish_winners(winners, "round")
    display_score
    save_game_to_file
    winners
  end
  
  # plays a set of games until one player reaches best_of
  #
  # returns game
  def play_best_of_game_set
     while game.highest_player_score < best_of
       play_game
     end
     publish_winners(game.players_with_highest_score, "game")
  end
  
  # displays the current score for each player
  #
  # returns nil
  def display_score()
    puts "Current score:"
    game.get_score.each {|player, score| puts "#{player}:\t#{score}" }
  end
  
  # saves game to file
  #
  # returns nothing
  def save_game_to_file
    save_to_file("\nNew Game:")
    game.players.each {|player, score| save_to_file "\n#{player.name} played #{player.move} and has #{player.score}." }
  end
  
  # publishes who won to screen
  #
  # player - player object
  #
  # returns nil
  def publish_winners(winners, game_type)
    winners.each do |winner|
      puts "#{winner.name} won #{game_type}!"
    end
  end
  
  # saves the string to file
  #
  # save_string - String
  #
  # returns nothing
  def save_to_file(save_string)
   # puts dir.pwd
    output = File.open( file_name,"a" )
    output << save_string
    output.close
  end
  
  private
  # String of the file_name where you want to save
  def file_name
    "/Users/gwendolyn/Code/06-06-paper_rock_scissors/outputfile.txt"
  end
  # get each player's move
  # if it's a computer, get a sample
  #
  # returns nothing
  def get_player_moves
    game.players.each do |player|
      #if the game didn't choose the computer's move
      #   get the user's move
      if game.set_computer_moves?(player)
        show_computer_move(player)
      else
        set_users_move(player)
      end
    end
  end
  
  # set user's move
  #
  # player - Player object
  #
  # returns nothing
  def set_users_move(player)
    move = get_users_move(player.name).to_sym
    while !game.set_player_move?(player, move)
      move = get_users_move(player.name).to_sym
    end
  end
  
  # show computer's output to screen
  #
  # returns nil
  def show_computer_move(player)
    puts "#{player.name}, what move?"
    puts player.move
  end
  
  # aks the user for a move and returns only a valid move
  #
  # returns String
  def get_users_move(name)
    move = get_user_input("#{name}, what move?")
  end
  
  # Set or default integer of how many games you are playing in this game
  #
  # num_games - Integers
  #
  # returns Integer
  def set_best_of(num_games=3)
    @best_of = num_games
  end
  
  # asks user for all players for :players until they type quit
  #
  # returns game
  def get_user_players
    player_name = get_user_input("Enter the name of who is playing or #{quit} to stop entering players.")
    while player_name.upcase != quit.upcase
      game.add_player_to_players(create_player(player_name))
      player_name = get_user_input("Enter the name of who is playing or #{quit} to stop entering players.")
    end
    game
  end
  
  # checks if there are enough humans
  # if not, makes computer players
  #
  # returns players
  def add_computer_players_if_not_enough_humans
    while !game.enough_human_players?
      game.add_player_to_players(create_computer_player)
    end
  end
  
  # creates a newly created Computer Player object
  #
  # returns ComputerPlayer
  def create_computer_player
    new_player = ComputerPlayer.new("computer")
  end
  
  # return a newly created Player Object
  #
  # returns Player
  def create_player(name)
    new_player = Player.new(name)
  end
  
  # returns a Quit message that stops the loop
  #
  # returns String
  def quit
    "Quit"
  end
  
  # sends a user a message and returns their response
  #
  # message - String
  #
  # returns a string
  def get_user_input(message)
    puts message
    gets.chomp
  end
end