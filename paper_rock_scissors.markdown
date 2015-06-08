# PaperRockScissors

PaperRockScissors is a class that plays the game paper rock scissors.  It has two parameters.  @players is an array of Player objects.  @needed_players is an integer of the number of needed players for the game.

To initialize, the user sends the number of needed players.  The initialize function sets that or a default number of players (at 2). The @players Array is initialized.

```ruby
  # if args are entered, sets the needed players
  # initializes players as an empty array
  #
  # returns self
   def initialize(args)
     @players = []
     if args[:needed_players].nil?
       set_needed_players
     else
       set_needed_players(args[:needed_players])
     end
   end
```

The game has a few definitions that are useful for game play.  winning_play is a Hash of each possible play with the plays that it beats.  possible_plays is an array of all possible plays by any player.  rules is just a string of the rules that can be printed for the user.

```ruby
   # Hash of the plays - put in the user's play, and you will see what it beats
   def winning_play
     {paper: [:rock, :spock], rock: [:lizard, :scissors], scissors: [:paper, :lizard], lizard: [:spock, :paper], spock: [:rock, :scissors], scratch: [:scratch]}
   end
   
   # Array of the plays each player can use
   def possible_plays
     [:paper, :rock, :scissors, :spock, :lizard]
   end
   
   # String of the rules of the game
   def rules
     "Choose rock, paper, scissors, lizard, or spock."
   end
   ```ruby
   
   
   The game is responsible for keeping track of the players, playing a game, and keeping track of the score.
   
   To add players, pass a player object, and game will push that player into players.
   
   ```ruby
   # adds a player to :players
   #
   # player - Player object
   #
   # returns players
   def add_player_to_players(player)
     players.push(player)
   end
   ```
   
   To play a game, call play_a_game, which will get a new move from each player, get the winners, add to each winner's score, and return winners.  The methods called in this method are all private utility methods within game.  The user does not need to know how it works in order to play.  But basically, it is pairing each player off and using the hash to determine the winners.
   
   ```ruby
   # plays a single game and gets the winners nad saves the score
   #
   # returns array of winning players
   def play_a_game
     get_each_players_move
     winners = get_games_winners
     save_winners(winners) unless winners.nil?
     winners
   end
   ```
   Users can use the highest_player_score to get the highest score for any user (for tournaments, etc) (returned as an integer). The method players_with_highest_score will return an array of all players who have the highest score (useful to find the winners after a game or tournament).  If you just want scores for all winners, you can get that back in a Hash from the get_score method.
   
   The final public method is called enough_human_players? which checks to make sure that the number of players in @players is more than the needed_players attribute.  This is relevant for the game driver to check to make sure enough players can play the game.
   
   
   ##Player class
   The player class stores three variables - name, score, and move.  Name is a string.  Score is an integer, initialized to 0, and move is a string.
   
   ```ruby
   class Player
      attr_reader :name
      attr_reader :score
      attr_accessor :move
   
      def initialize(name)
          @name = name
          @score = 0
          @move = ""
      end
    ```
   The Game class passes the Array of valid moves (called possible_plays above) to the player when they are asking the Player to set a valid move.  The game is responsible for knowing the valid moves.  But the player is responsible for choosing a valid move.
   
   The set_valid_move will ask the player for a move and loop until a valid move is chosen by the user.  Then it will set the user's input to the @move variable.
    
   ```ruby
   def set_valid_move(valid_move)
     @move = get_valid_move(valid_move)
   end
   
   # gets a valid move from the user
   #
   # valid_move - Array of all valid moves
   #
   # returns String of valid move
   def get_valid_move(valid_move)
     puts "Moves: #{valid_move.join("\t")}"
     try_move = get_user_input("#{name}, choose your move.").to_sym
     while !valid_move.include?(try_move)
       try_move = get_user_input("Not a valid move.  Try again.").to_sym
     end
     try_move
   end
   ```
   
   By making the player responsible for setting the moves, you can make ComputerPlayer a child class of Player, so that you can substitute in a ComputerPlayer for a Player.
   
   ###ComputerPlayer
   
   The computer player inherits all functionality from Player, except that when you ask it to pick a valid move, it samples from the array of valid_moves provided by game instead.
   
   ``` ruby
   class ComputerPlayer < Player
     # selects an item from the valid_move array at random
     #
     # returns String of valid move
     def get_valid_move(valid_move)
       my_move = valid_move.sample
       puts "My AI chooses #{my_move}"
       my_move
     end
  
   end
   ```
   
   #GameDriver
   The GameDriver class is repsonsible for running the game, getting the right number of players, and publishing those results to the screen.
   
   GameDrive has two attributes - game (a Game object) and best_of (an integer of the number of games it should run in a set). best_of is an optional parameter and will be set to 3 by default.  
   
   
   ```ruby
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
   ```  
   
   Since Game does not need players at the initializing stage and because GameDriver's job is also to set up players, you can add players to the Game using two methods.   set_up_these_players_plus_any_more_reuired will allow you to pass an Array of player objects to the Game, and in addition, the GameDriver will check to make sure that no other players are required.  If they are, gamedriver will create ComputerPlayers and add them to the game.
   
   
   ```ruby
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
   ```
   
   Or the GameDriver can add players by asking the user to set them up.  set_up_enough_players will ask the user for players names and will create new players for the game.  If the user doesn't add enough players, GameDriver will add ComputerPlayers.
   
   ```ruby
   # gets enough players for game
   #
   # returns game
   def set_up_enough_players
     get_user_players
     add_computer_players_if_not_enough_humans
     game
   end
   ```
   
   To play a game, you can call play_game or play_best_of_game_set.  These will not only call game to play the game, they will also publish the score and the winers.  play_best_of_game_set will keep playing games until the highest score of at least one player = best_of.
   
   ```ruby
   # plays a game & displays the score
   #
   # returns nil
   def play_game
     winners = game.play_a_game
     publish_winners(winners, "round")
     display_score
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
   ```
   
   The other two public methods of GameDriver are display_score and publish_winners.  These two classes will simply gather this information from the game and display them to the screen.
   
   In addition, GameDriver has a number of utility methods to get information from the users or publish information to the users.
   
   Since Game controls the rules, you should be able to use GameDriver for other games, as long as they are duck types in that they have players, allow you to add players, play a game, and get the winners.
   
   #App.rb
   An example of how to run GameDriver is below.  You will need to use both Game (which you pass to the GameDriver)
   

   ```ruby
   require_relative "game.rb"
   require_relative "game_driver.rb"

   args = {}
   new_game = PaperRockScissorsGame.new(args)
   g_driver = GameDriver.new(game: new_game)
   g_driver.set_up_enough_players
   g_driver.play_game
   g_driver.play_best_of_game_set
   ```