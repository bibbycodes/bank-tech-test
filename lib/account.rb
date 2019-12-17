class Account
  def initialize
    @balance = 0
    @ledger = []
  end

  def add_transaction(transaction)
    if transaction.type == "deposit"
      @balance += transaction.amount
    else
      @balance -= transaction.amount
    end
    @ledger.push(transaction)
    return transaction
  end

  def get_total
    return @balance
  end

  def get_ledger
    @ledger
  end
end