# frozen_string_literal: true

# Top level class

class StatementPrinter
  def make_headers
    'date || credit || debit || balance'
  end

  def format_output(transaction, account)
    if transaction.type == 'deposit'
      "#{transaction.date} || #{format('%.2f', transaction.amount)} || || #{format('%.2f', account.balance)}"
    else
      "#{transaction.date} || || #{format('%.2f', transaction.amount)} || #{format('%.2f', account.balance)}"
    end
  end

  def return_statement(account)
    headers = make_headers
    transactions_string = ''
    account.ledger.each do |transaction|
      transaction = format_output(transaction, account)
      transactions_string += (transaction + "\n")
    end
    headers + "\n" + transactions_string[0...-1]
  end
end
