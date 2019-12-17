## Account Statement Printer

This repository contains code for a simple Bank Account Statement Printer.
You can make a new transaction by using the Transaction class:

```ruby
deposit = Transaction.new('10/01/2019', 1000, 'deposit')
withdrawal = Transaction.new('12/01/2019', 500, 'withdrawal')
```

this transaction can then be added to an account by using the Account class:

```ruby
account = Account.new
account.add_transaction(deposit)
account.add_transaction(withdrawal)
```

Once you have some transactions in your account, you can print the statement using the Printer class:

```ruby
statement = StatementPrinter.new

print (statement.return_statement(account))
```

This Prints a formatted statement to the console:

