# frozen_string_literal: true

# Top level class

class Account
  attr_reader :balance, :ledger
  def initialize
    @balance = 0
    @ledger = []
  end

  def add_transaction(transaction)
    if transaction.type == 'deposit'
      @balance += transaction.amount
    else
      @balance -= transaction.amount
    end
    @ledger.push(transaction)
    transaction
  end
end
