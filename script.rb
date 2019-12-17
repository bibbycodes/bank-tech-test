require_relative './lib/account'
require_relative './lib/statement_printer'
require_relative './lib/transaction'

account = Account.new
printer = StatementPrinter.new
deposit = Transaction.new('10/01/2019', 1000, 'deposit')
deposit_2 = Transaction.new('11/01/2019', 1000, 'deposit')
withdrawal = Transaction.new('12/01/2019', 500, 'withdrawal')
withdrawal_2 = Transaction.new('13/01/2019', 1000, 'withdrawal')

transactions_arr = [deposit, deposit_2, withdrawal, withdrawal_2]

transactions_arr.each do |transaction|
  account.add_transaction(transaction)
end 

print (printer.return_statement(account))