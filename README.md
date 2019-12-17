## Account Statement Printer
This repository contains code for a simple Bank Account Statement Printer.
#### Usage:

You can make a new transaction by using the Transaction class:

```ruby
deposit = Transaction.new('10/01/2019', 1000, 'deposit')
withdrawal = Transaction.new('12/01/2019', 500, 'withdrawal')
```

These transactions can then be added to an account by using the Account class:

```ruby
account = Account.new
account.add_transaction(deposit)
account.add_transaction(withdrawal)
```

Once you have some transactions in your account, you can print the statement using the StatementPrinter class:

```ruby
statement = Statement.new

print (statement.return_statement(account))
```

This Prints a formatted statement to the console:

![Output](./img.png?raw=true "Title")

## Approach:

I first started with a Bank class.
I used Tests to drive the development.
This inevitably led to the formation of three distinct classes as it 
became apparent that certain methods did not match with the others.

These methods were then extracted into the following classes:

#### Transactions Class

This is a simple class that takes in arguments for the date, amount and type 
of transaction and returns an object that represents a single transaction.

#### Account Class

This is a class that has two attrributes: ledger and balance.
It also contains one method for adding a transaction. Depending on the transaction type,
the balance will be adjusted accordingly.

#### Statement Class

The final class has no attributes associated with it.
It has three methods. One that returns a formatted string representing a single transaction, 
another to return the headers and a final method that takes in an account object as an argument and 
returns a formatted, readable statement with the headers included.

NB the code for the example above is contained withi example_script.rb
