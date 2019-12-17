class StatementPrinter
  def make_headers
    "date || credit || debit || balance"
  end

  def format_output(transaction, account)
    if transaction.type == "deposit"
      "#{transaction.date} || #{sprintf('%.2f', transaction.amount)} || || #{sprintf('%.2f', account.balance)}"
    else
      "#{transaction.date} || || #{sprintf('%.2f', transaction.amount)} || #{sprintf('%.2f', account.balance)}"
    end
  end

  def return_statement(account)
    headers = self.make_headers
    transactions_string = ""
    account.ledger.each do |transaction|
      transaction = format_output(transaction, account)
      transactions_string += (transaction + "\n")
    end
    return headers + "\n" + transactions_string[0...-1]
  end
end