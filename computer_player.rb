require_relative "player.rb"

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