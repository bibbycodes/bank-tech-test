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
end