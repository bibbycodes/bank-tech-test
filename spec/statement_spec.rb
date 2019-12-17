# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:deposit_1) { double('Transaction', date: '10/10/2012', amount: 1000, type: 'deposit') }
  let(:deposit_2) { double('Transaction', date: '01/01/2020', amount: 2000, type: 'deposit') }
  let(:withdrawal) { double('Transaction', date: '03/02/2020', amount: 2000, type: 'withdrawal') }
  let(:account) { double('Account', balance: 1000, ledger: [deposit_1]) }
  let(:account_2) { double('Account', balance: 3000, ledger: [deposit_1, deposit_2]) }

  before(:each) do
    @printer = Statement.new
  end

  context '#return_statement' do
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
