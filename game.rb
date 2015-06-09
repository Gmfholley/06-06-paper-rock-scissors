require_relative "player.rb"

class PaperRockScissorsGame
  
  # Array of Player objects
  attr_reader :players, :needed_players
   
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
   
   # adds a player to :players
   #
   # player - Player object
   #
   # returns players
   def add_player_to_players(player)
     players.push(player)
   end  
   
   # plays a single game and gets the winners nad saves the score
   #
   # returns array of winning players
   def play_game_with_current_moves
     winners = get_games_winners
     save_winners(winners) unless winners.nil?
     winners
   end
   
   # returns the highest player's score
   #
   # returns an int of the highest player score
   def highest_player_score
    players.max_by{|player| player.score}.score
   end
   
   # returns an Array of the players who won
   #
   # returns an array
   def players_with_highest_score
     players.select{|player| player.score >= highest_player_score}
   end

   # gets the current score for each player
   #
   # returns a Hash of each player's name and their score
   def get_score()
       score = Hash.new(0)
       players.each {|player| score[player.name] = player.score}
       score
   end 
   
   # shows whether there are at least two players
   #
   # returns boolean
   def enough_human_players?
     players.length >= needed_players
   end
   
   # asks each player for their move
   #
   # player - Player object
   # move - String
   #
   # returns players
   def set_player_move(player, move)
     player.move = move
   end
  
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
  
   private
  
   # returns the number of needed players in the game
   def set_needed_players(num_players=2)
     @needed_players = num_players
   end

   # increment winners' scores and put them to screen
   #
   # winners - array of winners (player objects)
   #
   # returns winners
   def save_winners(winners)
      winners.each do |winner| 
        winner.increment_score()
      end
    end
     
    # returns an Array of winner(s)
    #
    # returns Array
    def get_games_winners
      tally = all_player_tally #tally is a hash with the combination of scores between all players
      winner_tally = hash_select_by_max_key(tally)
      return convert_hash_keys_to_array(winner_tally)
    end
   
   # returns an Array of the keys of this hash
   #
   # hash with the keys you want in an array
   #
   # returns Array
   def convert_hash_keys_to_array(hash)
      array = []
      hash.each do |k, v|
          array.push(k)
      end
      array
   end
   
   # selects from hash that has the highest value
   #
   # hash - Hash
   #
   # returns a Hash
   def hash_select_by_max_key(hash)
      return hash.select{|k, v|  v == hash.values.max}
   end
   
   # returns Hash of plqyers and their scores against all other players
   # 
   # returns Hash
   def all_player_tally
     tally = Hash.new(0)
     players.each do |player|
        players.each do |against_player|
           winners_between_two_players(player, against_player).each do |winner|
             tally[winner] += 1
           end
         end
      end
      tally
   end 
   
   # returns an array of the winner(s) of a two-player game (allowing for a tie)
   #
   # player, against_player are Player objects
   #
   # returns an Array
   def winners_between_two_players(player, against_player)
     
     #if player's winning move = against_player's move, player wins
     if winning_play[player.move].include?(against_player.move)
        return [player]
     # if against_player.move is the winning play, against_player is the winner
     elsif winning_play[against_player.move].include?(player.move)
        return [against_player]
     # otherwise, they tied (ie - both won)  
     else    
        return [player, against_player]
     end
   end
   
end