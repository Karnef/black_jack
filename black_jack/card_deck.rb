class CardDeck
  attr_accessor :points
  attr_reader :card_deck, :cards, :deck_hash, :deck_arr

  def initialize
    @deck_hash = {
      '2♣': 2, '3♣': 3, '4♣': 4, '5♣': 5, '6♣': 6, '7♣': 7, '8♣': 8,
      '9♣': 9, '10♣': 10, J♣: 10, Q♣: 10, K♣: 10, A♣: 11,
      '2♥': 2, '3♥': 3, '4♥': 4, '5♥': 5, '6♥': 6, '7♥': 7, '8♥': 8,
      '9♥': 9, '10♥': 10, J♥: 10, Q♥: 10, K♥: 10, A♥: 11,
      '2♠': 2, '3♠': 3, '4♠': 4, '5♠': 5, '6♠': 6, '7♠': 7, '8♠': 8,
      '9♠': 9, '10♠': 10, J♠: 10, Q♠: 10, K♠: 10, A♠: 11,
      '2♦': 2, '3♦': 3, '4♦': 4, '5♦': 5, '6♦': 6, '7♦': 7, '8♦': 8,
      '9♦': 9, '10♦': 10, J♦: 10, Q♦: 10, K♦: 10, A♦: 11
    }
  end

  def give_random_card
    @deck_arr = []
    @deck_hash.each { |cards, _volue| @deck_arr << cards }
    card = @deck_arr.sample
    @deck_arr.delete(card)
    card
  end

  def count_points(cards)
    @points = 0
    cards.each do |card|
      @points += @deck_hash[card.to_sym]
      @points -= 10 if points > 21 && cards.join('').include?('A')
    end
    @points
  end
end
