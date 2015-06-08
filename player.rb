class Player
   attr_reader :name
   attr_reader :score
   attr_accessor :move
   
   def initialize(name)
       @name = name
       @score = 0
       @move = ""
   end
   
   def increment_score()
     @score += 1
   end
      
   # sets a valid move from the valid_move Array
   #
   # valid_move     - Array of what to check against
   #
   # returns String (move)
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
   
   private
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
  