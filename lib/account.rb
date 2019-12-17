# You should be able to interact with your code via a REPL like IRB or the JavaScript console. 
# (You don't need to implement a command line interface that takes input from STDIN.)
# Deposits, withdrawal
# Account statement (date, amount, balance) printing.
# Data can be kept in memory (it doesn't need to be stored to a database or anything).

# Given a client makes a deposit of 1000 on 10-01-2012
# And a deposit of 2000 on 13-01-2012
# And a withdrawal of 500 on 14-01-2012
# When she prints her bank statement
# Then she would see

# date       || credit   || debit  || balance
# 14/01/2012 ||          || 500.00 || 2500.00
# 13/01/2012 || 2000.00  ||        || 3000.00
# 10/01/2012 || 1000.00  ||        || 1000.00

# date || credit || debit || balance
# 14/01/2012 || || 500.00 || 2500.00
# 13/01/2012 || 2000.00 || || 3000.00
# 10/01/2012 || 1000.00 || || 1000.00

class Account
  def initialize
    @balance = 0
    @ledger = []
  end

  # def withdraw_at(date, amount)
  #   balance = self.make_withdrawal(amount)
  #   transaction =  {
  #     "date" => date,
  #     "amount" => amount,
  #     "total" => @balance,
  #     "type" => "withdrawal"
  #   }
  #   @ledger.push(transaction)
  #   transaction
  # end

  # def deposit_at(date, amount)
  #   balance = self.add_deposit(amount)
  #   transaction =  {
  #     "date" => date,
  #     "amount" => amount,
  #     "total" => @balance,
  #     "type" => "deposit"
  #   }
  #   @ledger.push(transaction)
  #   transaction
  # end

  def make_headers
    "date || credit || debit || balance"
  end

  def format_output(activity)
    if activity["type"] == "deposit"
      "#{activity["date"]} || #{sprintf('%.2f', activity["amount"])} || || #{sprintf('%.2f', @balance)}"
    else
      "#{activity["date"]} || || #{sprintf('%.2f', activity["amount"])} || #{sprintf('%.2f', @balance)}"
    end
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

  def return_statement
    headers = self.make_headers
    transactions_string = ""
    @ledger.each do |transaction|
      transaction = format_output(transaction)
      transactions_string += (transaction + "\n")
    end
    return headers + "\n" + transactions_string[0...-1]
  end
end