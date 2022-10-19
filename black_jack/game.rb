class Game
  attr_reader :user, :dealer, :card_deck, :bank

  def initialize
    @dealer = Dealer.new
    @bank = Bank.new
    @card_deck = CardDeck.new
  end

  DEALER_SCORE_CHOICE = 17
  MAX_POINTS = 21
  MAX_CARDS = 3

  def greeting
    puts "Welcome to the game"
    puts "Are you ready?\n1 - Yes\n2 - No"
    choice = gets.to_i
    case choice
    when 1
      puts "Enter ur name:"
      name = gets.chomp
      @user = User.new(name)
      puts "Your balance: #{user.balance}$"
      puts "Start"
      round
    when 2
      puts "Good luck"
    else
      puts "err"
      greeting
    end
  end

  def round
    @user.new_round
    @dealer.new_round
    2.times { user.add_cards(card_deck) }
    puts "\nYour hand: #{user.cards_on_hand}"
    2.times { @dealer.add_cards(card_deck) }
    puts "Dealer cards: #{@dealer.close_cards}"
    @bank.take(user)
    @bank.take(dealer)
    puts "Your score: #{card_deck.count_points(user.cards_on_hand)}"
    user_choice
  end

  def user_choice
    open if @dealer.cards_on_hand.count == MAX_CARDS && @user.cards_on_hand.count == MAX_CARDS
    puts "Your move:"
    puts "1 - skip"
    puts "2 - add card"
    puts "3 - open cards"
    puts "0 - end game"
    input
  end

  def input
    choice = gets.to_i
    case choice
    when 1
      puts "#{dealer.name} turn"
      dealer_choice
    when 2
      if @user.cards_on_hand.count == 2
        @user.add_cards(card_deck)
        puts "Your hand: #{user.cards_on_hand}"
        puts "Your score: #{card_deck.count_points(user.cards_on_hand)}"
        dealer_choice
      else
        puts "You can take card, if you have only 2 cards on hand"
        user_choice
      end
    when 3
      open
    when 0
      puts "Good luck"
      abort
    end
  end

  def open
    puts "Open hands"
    puts "Your cards: #{user.open_cards}, your score: #{card_deck.count_points(user.cards_on_hand)}"
    puts "Dealer cards: #{dealer.open_cards}, dealer score: #{card_deck.count_points(dealer.cards_on_hand)}"
    winner
  end

  def dealer_choice
    open if @user.cards_on_hand.count == MAX_CARDS && @dealer.cards_on_hand.count == MAX_CARDS
    if card_deck.count_points(dealer.cards_on_hand) >= DEALER_SCORE_CHOICE
      puts "Dealer skip"
      user_choice
    elsif card_deck.count_points(dealer.cards_on_hand) < DEALER_SCORE_CHOICE
      dealer.add_cards(card_deck)
      puts "Dealer take the card: #{@dealer.close_cards}"
      user_choice
    else
      puts "Dealer don't take the card"
    end
  end

  def winner
    @user_points = @card_deck.count_points(user.cards_on_hand)
    @dealer_points = @card_deck.count_points(dealer.cards_on_hand)

    if (@user_points > @dealer_points && @user_points <= MAX_POINTS) || (@user_points <= MAX_POINTS && @dealer_points > MAX_POINTS)
      puts "Congrats! You win. Your balance = #{@user.balance += @bank.balance_bank}$"
      puts "Dealer balance: #{@dealer.balance}$"
      @bank.balance_bank = 0
    elsif @user_points < @dealer_points || @user_points > MAX_POINTS
      puts "You lose. Your balance: #{@user.balance}$"
      puts "Dealer balance: #{@dealer.balance += @bank.balance_bank}$"
      @bank.balance_bank = 0
    else
      @user_points == @dealer_points
      @bank.give(user)
      @bank.give(dealer)
      puts "Draw. Your balance: #{@user.balance}$. Dealer balance: #{@dealer.balance}$"
      @bank.balance_bank = 0
    end

    round if @user.balance != 0 || @dealer.balance != 0
    restart if @user.balance.zero? || @dealer.balance.zero?
  end

  def restart
    puts "Are you wanna return game? 1 - yes, 2 - no"
    input = gets.to_i
    greeting if input == 1
    exit if input == 2
  end
end
