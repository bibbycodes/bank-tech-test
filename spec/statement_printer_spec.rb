require 'statement_printer'
describe StatementPrinter do
  let(:deposit_1) { double("Transaction", :date => "10/10/2012", :amount => 1000, :type => "deposit") }
  let(:deposit_2) { double("Transaction", :date => "01/01/2020", :amount => 2000, :type => "deposit") }
  let(:withdrawal) { double("Transaction", :date => "03/02/2020", :amount => 2000, :type => "withdrawal") }
  let(:account) { double("Account", :balance => 1000, :ledger => [deposit_1] )}
  let(:account_2) { double("Account", :balance => 3000, :ledger => [deposit_1, deposit_2] )}
  let(:account_3) { double("Account", :balance => 5000, :ledger => [deposit_1, deposit_2, withdrawal] )}

  before(:each) do
    @printer = StatementPrinter.new
  end

  context "#makeHeaders" do
    it "returns date || credit || debit || balance" do
      expect(@printer.make_headers).to eq("date || credit || debit || balance")
    end
  end

  context "#format_output" do
    it "formats a string for a deposit of 2000 at 01/01/2020" do
      expect(@printer.format_output(deposit_2, account_2)).to eq("01/01/2020 || 2000.00 || || 3000.00")
    end

    it "formats a string for a deposit of 1000 at 10/10/2020" do
      expect(@printer.format_output(deposit_1, account)).to eq("10/10/2012 || 1000.00 || || 1000.00")
    end

    it "formats a string for a withdrawal of 2000 at 03/01/2020 for an account with 1000 inside" do
      expect(@printer.format_output(withdrawal, account)).to eq("03/02/2020 || || 2000.00 || 1000.00")
    end
  end

  context "#return_statement" do
    it 'returns

        date || credit || debit || balance
        10/01/2012 || 1000.00 || || 1000.00

        when one deposit of 1000 has been made into an empty account
        ' do
      expect(@printer.return_statement(account)).to eq(
        "date || credit || debit || balance\n10/10/2012 || 1000.00 || || 1000.00"
      )
    end
  end
end