class Player
  # name  - String of name
  # score - Integer of player's score (starts at 0)
  # move  - String of player's move
   
   attr_reader :name
   attr_reader :score
   attr_accessor :move
   
   # initializes Player
   #    @score set to 0
   #    @move set to empty string
   #
   # name - String of the name
   # 
   def initialize(name)
       @name = name
       @score = 0
       @move = ""
   end
   
   # adds one to Player's score
   #
   # returns score + 1
   def increment_score()
     @score += 1
   end
   
   # indicates whether Player is a computer
   #
   # returns boolean (false)
   def is_computer?
     false
   end
   
end
  