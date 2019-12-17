require 'account'

describe Account do
  let(:deposit) { double("Transaction", :date => "10/10/2012", :amount => 1000, :type => "deposit") }
  let(:withdrawal) { double("Transaction", :date => "02/10/2012", :amount => 2000, :type => "withdrawal") }

  before(:each) do
    @account = described_class.new
    @empty_account = described_class.new
    @full_account = described_class.new
    4.times { @full_account.add_transaction(deposit) }
  end

  context "#add_transaction" do
    it "adds a deposit to ledger" do
      expect(@account.add_transaction(deposit)).to eq(deposit)
    end

    it "adds a withdrawal to the ledger" do
      @account.add_transaction(deposit)
      @account.add_transaction(deposit)
      expect(@account.add_transaction(withdrawal)).to eq(withdrawal)
    end

    it "adds a withdrawal to the ledger" do
      expect(@full_account.add_transaction(withdrawal)).to eq(withdrawal)
    end
  end

  context "#get_total" do
    it "returns 0 when nothing has been deposited" do
      expect(@empty_account.get_total).to eq(0)
    end

    it "returns 1000 when 1000 has been deposited" do
      @empty_account.add_transaction(deposit)
      expect(@empty_account.get_total).to eq(1000)
    end

    it "returns 2000 when 2000 has been deposited" do
      2.times { @empty_account.add_transaction(deposit) }
      expect(@empty_account.get_total).to eq(2000)
    end

    it "returns 2000 when 2000 has been withdrawn from an account with 4000 inside" do
      @full_account.add_transaction(withdrawal)
      expect(@full_account.get_total).to eq(2000)
    end
  end

  context "#get_ledger" do
    it "returns an empty list when there are no transactions" do
      expect(@account.get_ledger).to eq([])
    end

    it "returns [deposit, withdrawal] when a deposit followed by a withdrawal has been made" do
      @account.add_transaction(deposit)
      @account.add_transaction(withdrawal)
      expect(@account.get_ledger).to eq([deposit, withdrawal])
    end
  end
end