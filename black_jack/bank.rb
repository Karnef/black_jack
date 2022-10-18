class Bank
  attr_accessor :balance_bank, :bet
  attr_reader :player

  def initialize
    @balance_bank = 0
    @bet = 10
  end

  def give(player)
    player.balance += @bet
    self.balance_bank -= @bet
  end

  def take(player)
    player.balance -= @bet
    self.balance_bank += @bet
  end
end
