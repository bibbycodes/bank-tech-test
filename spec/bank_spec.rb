require 'bank'

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
# 13/01/2012 || 2000.00  ||        || 1000.00
# 10/01/2012 || 1000.00  ||        || 1000.00

# date || credit || debit || balance
# 14/01/2012 || || 500.00 || 2500.00
# 13/01/2012 || 2000.00 || || 1000.00
# 10/01/2012 || 1000.00 || || 1000.00

describe Bank do
  before(:each) do
    @bank = Bank.new
  end
    
  context "#makeHeaders" do
    it "returns date || credit || debit || balance" do
      expect(@bank.make_headers).to eq("date || credit || debit || balance")
    end
  end

  context "#add_deposit" do
    it "adds 1000 to the bank balance" do
      expect(@bank.add_deposit(1000)).to eq(1000)
    end

    it "adds 2000 to the bank balance" do
      expect(@bank.add_deposit(2000)).to eq(2000)
    end
  end

  context "#get_total" do
    bank_2 = Bank.new
    it "returns 0 when nothing has been deposited" do
      expect(bank_2.get_total).to eq(0)
    end

    it "returns 1000 when 1000 has been deposited" do
      bank_2.add_deposit(1000)
      expect(bank_2.get_total).to eq(1000)
    end

    it "returns 2000 when 2000 has been deposited" do
      bank_2.add_deposit(1000)
      expect(bank_2.get_total).to eq(2000)
    end
  end

  context "#make_withdrawal" do
    before(:each) do
      @bank_3 = Bank.new
      @bank_3.add_deposit(1000)
    end

    it "returns 500 when 500 is withdrawn" do
      expect(@bank_3.make_withdrawal(500)).to eq(500)
    end

    it "returns 200 when 800 is withdrawn" do
      expect(@bank_3.make_withdrawal(800)).to eq(800)
    end
  end

  context "#withdraw_at" do
    before(:each) do
      @bank_4 = Bank.new
      @bank_4.add_deposit(4000)
    end

    it "returns a hash with the traansaction details when a withdrawal of 500 is made on 01/01/2020 from an account with 4000 inside" do
      expect(@bank_4.withdraw_at("01/01/2020", 500)).to eq({
        "date" => "01/01/2020",
        "amount" => 500,
        "total" => 3500,
        "type" => "withdrawal"
      })
    end

    it "returns a hash with the traansaction details when a withdrawal of 1000 is made on 01/01/2020 from an account with 4000 inside" do
      expect(@bank_4.withdraw_at("01/02/2020", 1000)).to eq({
        "date" => "01/02/2020",
        "amount" => 1000,
        "total" => 3000,
        "type" => "withdrawal"
      })
    end
  end

  context "#deposit_at" do
    it "returns a hash with the traansaction details when a deposit of 1000 is made on 01/01/2020 into an empty account" do
      expect(@bank.deposit_at("01/01/2020", 1000)).to eq({
        "date" => "01/01/2020",
        "amount" => 1000,
        "total" => 1000,
        "type" => "deposit"
      })
    end

    it "returns '[01/02/2020, 2000]' when a deposit of 1500 is made on 01/02/2020 into an account with 500 inside" do
      @bank.add_deposit(500)
      expect(@bank.deposit_at("01/02/2020", 1500)).to eq({
        "date" => "01/02/2020",
        "amount" => 1500,
        "total" => 2000,
        "type" => "deposit"
      })
    end
  end

  context "#format_output" do
    before(:each) do
      @bank_5 = Bank.new
    end
    it "formats a string for a deposit of 500 at 01/01/2020" do
      deposit = @bank_5.deposit_at("01/01/2020", 500)
      expect(@bank_5.format_output(deposit)).to eq("01/01/2020 || 500.00 || || 500.00")
    end

    it "formats a string for a deposit of 1000 at 03/01/2020" do
      deposit = @bank_5.deposit_at("03/01/2020", 1000)
      expect(@bank_5.format_output(deposit)).to eq("03/01/2020 || 1000.00 || || 1000.00")
    end

    it "formats a string for a deposit of 1000 at 03/01/2020 when there is already 1000 in the account" do
      @bank_5.deposit_at("02/01/2020", 1000)
      deposit = @bank_5.deposit_at("03/01/2020", 1000)
      expect(@bank_5.format_output(deposit)).to eq("03/01/2020 || 1000.00 || || 2000.00")
    end

    it "formats a string for a withdrawal of 500 at 01/01/2020 for an account with 1000 inside" do
      @bank_5.add_deposit(1000)
      deposit = @bank_5.withdraw_at("01/01/2020", 500)
      expect(@bank_5.format_output(deposit)).to eq("01/01/2020 || || 500.00 || 500.00")
    end

    it "formats a string for a withdrawal of 500 at 01/01/2020 for an account with 2000 inside" do
      @bank_5.add_deposit(2000)
      deposit = @bank_5.withdraw_at("01/01/2020", 500)
      expect(@bank_5.format_output(deposit)).to eq("01/01/2020 || || 500.00 || 1500.00")
    end
  end

  context "#get_transactions" do
    it "returns an empty list when there are no transactions" do
      expect(@bank.get_transactions).to eq([])
    end

    it "returns a list of all transactions" do
      deposit = @bank.deposit_at("01/01/2020", 2000)
      withdrawal = @bank.withdraw_at("02/01/2020", 1000)
      expect(@bank.get_transactions).to eq([deposit, withdrawal])
    end
  end

  context "#return_statement" do
    it 'returns
        date || credit || debit || balance
        10/01/2012 || 1000.00 || || 1000.00

        when one deposit of 1000 has been made into an empty account
        ' do
      @bank.deposit_at("10/10/2012", 1000)
      expect(@bank.return_statement).to eq(
        "date || credit || debit || balance\n10/10/2012 || 1000.00 || || 1000.00"
      )
    end
  end
end