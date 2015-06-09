class TournamentRound
  attr_reader :players, :game_driver
  
  # initializes an array of players that are seeded in the order they arrive
  #
  # players - Array
  #
  def initialize(players)
    @players = players
    #@game_driver = game_driver
  end
  
  # returns an Array of Arrays of the brackets, paired off in order of seeding
  #
  # returns an Array
  def get_brackets
    brackets = []
    num_brackets = players.length/2 
    (1..num_brackets).each do |x|
      brackets.push([players[x-1], players[-x]])
    end
    brackets
  end
end
