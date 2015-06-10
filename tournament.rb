class TournamentRound
  attr_reader :players
  
  # initializes an array of players that are seeded in the order they arrive
  #
  # players - Array
  #
  def initialize(players)
    @players = players
  end
  
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
  
  # returns the number of brackets
  #
  # you should have a bracket of players.length / 2 as Integer - which should be the Floor
  #
  # returns Integer of number of brackets you should need
  def num_brackets
    players.length/2
  end
  
end
