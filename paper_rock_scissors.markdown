# PaperRockScissors

PaperRockScissors is a class that plays the game paper rock scissors.  It has two parameters.  @players is an array of Player objects.  @needed_players is an integer of the number of needed players for the game.

To initialize, the user optionally sends the number of needed players.  The default value is 2.  The @players Array is initialized as an Array.

```ruby
   def initialize(needed_players=2)
     @players = []
     @needed_players = needed_players
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
   
   To play a game, you must first set the moves.  Because app.rb may have to get moves from the user, app.rb must have access to call the set moves methods on each player, one at a time.  To change the correct player, Game's method must receive a Player object as a parameter.  In the case of the user picking a move, the method also needs to take the move as a parameter.
   
   
   Game has two methods for setting moves.  They both return booleans to indicate whether setting the move was successful.  The first method is set_player_move?.  It checks to see if the move the player passed is valid.  If yes, it sets the player's move attribute and returns true.  If not, it returns false. 
   
   ```ruby
   # sets the player's move if it is valid
   #
   # player - Player object
   # move - String
   #
   # returns boolean if it successfully set the move
   def set_player_move?(player, move)
     if possible_plays.include?(move)
        player.move = move
        true
      else
        false
      end
   end
  ```
  
  The second method works for ComputerPlayer objects.  To set a move, pass in a Player object.  If it is a computer player, it samples a move from possible_plays (the Array of valid moves) and returns true.  If it is not a ComputerPlayer, it returns false.
  
  (Note: Player/ComputerPlayer have a method called is_computer?)
  
  ```ruby
   # if the player is a computer, sets the move
   #
   # player - Player object
   #
   # returns true if able to do so, sets false if not
   def set_computer_moves?(player)
     if player.is_computer?
       move = possible_plays.sample
       player.move = move
       true
     else
       false
     end
   end
   ```
   call play_a_game_with_current_moves, which will play with current moves, get the winners, add to each winner's score, and return winners.  The methods called in this method are all private utility methods within game.  The user does not need to know how it works in order to play.  But basically, it is pairing each player off and using a Hash to determine the winners.
   
   ```ruby
   # plays a single game and gets the winners and saves the score
   #
   # returns array of winning players
   def play_game_with_current_moves
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
   
   Player has an increment_score method to increment the Player's score by 1.
   
   Player also has a is_computer? method which returns false.
   
   ``` ruby
   # indicates whether Player is a computer
   #
   # returns boolean (false)
   def is_computer?
     false
   end
   ```
  
   ###ComputerPlayer
   
   The computer player inherits all functionality from Player, except that is_computer? is true.
   
      
   ``` ruby
require_relative "player.rb"

class ComputerPlayer < Player
  
  # indicates of ComputerPlayer is a computer
  #
  # returns Boolean - true
  def is_computer?
    true
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
   
   To play a game, you can call play_game or play_best_of_game_set.  These will not only call game to play the game, they will also publish the score and the winners and save the game to file.  play_best_of_game_set will keep playing games until the highest score of at least one player = best_of.
   
   ```ruby
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
   ```
   
   The other public methods of GameDriver are display_score, publish_winners, and save_to_file.  These classes will  gather this information from the game, display them to the screen, and save the results to the file.
   
   In addition, GameDriver has a number of utility methods to get information from the users or publish information to the users.
   
   Since Game controls the rules, you should be able to use GameDriver for other games, as long as they are duck types in that they have players, allow you to add players, play a game, and get the winners.
  
   #TournamentRound Class
   
   The TournamentRound class takes an Array of objects in seeded order.  It stores that Array as :players, TournamentRound's single attribute.
   
   ```ruby
   class TournamentRound
     attr_reader :players
  
     # initializes an array of players that are seeded in the order they arrive
     #
     # players - Array
     #
     def initialize(players)
       @players = players
     end
  ```
  
  TournamentRound's get_brackets method returns an Array of Arrays, in which the highest seeded player is paired with the lowest seeded player, on down until there are no more pairs of players left.  If the number of players is odd, get_brackets will not return the median player in the get_brackets Array.
  
    ```ruby 
     # returns an Array of Arrays of the brackets, paired off in order of seeding
      #
      # returns an Array
      def get_brackets
        brackets = []
        (1..num_brackets).each do |x|
          brackets.push([players[x-1], players[-x]])
        end
        brackets
      end
   ```
   
   TournamentRound allows you to play a round of tournaments, if you're so inclined.
   
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
   
   To play an awesome tournament (which, hell yeah!  I want to do!), try this:
   
   First create some dummy players.  In this case, I will create players a - g.
   ```ruby
   ('a'..'g').each do |c|
     all_players.push(ComputerPlayer.new(c))
   end
   ```
   
   Those players are stored in an Array, which we will keep sending to the TournamentRound class to get brackets.  As each bracket is played, we will remove players from the Array.  And at the end of the Round, we will re-send the winning players into another TournamentRound to get the next bracket.
   
   ```ruby

   # all_players holds current players
   # when length of all_players is 1, you have a winner

   while all_players.length > 1
     puts "\nPlaying a new round in the tournament!"
     new_tournament = TournamentRound.new(all_players)
     brackets = new_tournament.get_brackets
    ```
    Here is what the play of the bracket looks like...
    ```ruby
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
       ```
       Now that the bracket's game is won, remove the losing player from the all_players list and loop again.
       ```ruby
       #remove loser from all_players

       players_for_game.delete(winners[0])
       all_players.delete(players_for_game[0])
     end
     puts "The ultimate winner is #{all_players[0].name}"
     ```
     
     And that is how you play the game!