require_relative "game_driver.rb"
require_relative "game.rb"
require "minitest/autorun"

class TestGameDriver < MiniTest::Test
  def test_initialize
    args = {}
    game = PaperRockScissorsGame.new(args)
    driver = GameDriver.new(game: game)
    
    assert_equal(game, driver.game)
    assert_equal(3, driver.best_of)
    
    driver2 = GameDriver.new(game: game, best_of: 4)
    assert_equal(4, driver2.best_of)
  
  end
  def test_

  
end


