require_relative "player.rb"
require_relative "computer_player.rb"
require "minitest/autorun"

class PlayerTest < MiniTest::Test
  
  def test_initialize
    p = Player.new("p")
    c = ComputerPlayer.new("c")
    
    assert_equal(0, p.score)
    assert_equal(0, c.score)
    assert_equal("p", p.name)
    assert_equal("c", c.name)
    assert_equal("", p.move)
    assert_equal("", c.move)
    assert_equal(false, p.is_computer?)
    assert_equal(true, c.is_computer?)
  end
    
  def test_increment_score
    p = Player.new("p")
    c = ComputerPlayer.new("c")
    
    p.increment_score
    c.increment_score
    
    assert_equal(1, p.score)
    assert_equal(1, c.score)
    
  end  
    
  
end