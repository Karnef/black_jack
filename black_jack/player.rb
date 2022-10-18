require_relative 'card_deck'
# родительский класс Игрок
# 2 игрока: пользователь и дилер(программа)

class Player
  attr_accessor :balance, :cards_on_hand, :name, :points
  attr_reader :card_deck

  def initialize(*_args)
    @name = name
    @balance = 100 # банк игрока
    @cards_on_hand = []
  end

  # добавить\взять карту. Добавляется 1 случайная карта
  def add_cards(card_deck)
    @cards_on_hand << card_deck.give_random_card
  end

  def open_cards
    @cards_on_hand.each { |card| card }
  end

  def new_round
    @cards_on_hand = []
  end
end
