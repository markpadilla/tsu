require_relative '../lib/blackjack'
require "minitest/autorun"
 
class TestSimpleNumber < MiniTest::Unit::TestCase
 
  def test_simple
  	@game = Blackjack.new
  	@game.set_dealer_cards(['Ace of Spades', 'Jack of Diamonds'])
  	@game.dealer_play()
  	assert_equal(21, @game.get_dealer_cards_value())
  	@game.set_player_cards(['Ace of Spades', 'Jack of Diamonds'])
  	@game.set_player_cards_value()
  	assert_equal(21, @game.get_player_cards_value())

  	@game = Blackjack.new
  	@game.set_dealer_cards(['4 of Spades', 'Jack of Diamonds', '8 of Spades'])
  	@game.dealer_play()
  	assert_equal(22, @game.get_dealer_cards_value())

  	@game = Blackjack.new
  	@game.set_dealer_cards(['6 of Spades', 'Jack of Diamonds', 'Ace of Spades'])
  	@game.dealer_play()
  	assert_equal(17, @game.get_dealer_cards_value())
  end
 
end