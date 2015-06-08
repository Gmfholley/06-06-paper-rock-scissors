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
    
   def is_computer?
     false
   end
   
end
  