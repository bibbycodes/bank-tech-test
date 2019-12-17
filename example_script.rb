require_relative './lib/account'
require_relative './lib/statement_printer'
require_relative './lib/transaction'

account = Account.new
printer = StatementPrinter.new
deposit = Transaction.new('10/01/2019', 1000, 'deposit')
withdrawal = Transaction.new('12/01/2019', 500, 'withdrawal')

account.add_transaction(deposit)
account.add_transaction(withdrawal)

print (printer.return_statement(account))