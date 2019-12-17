require 'transaction'

describe Transaction do
  context "#make_hash" do
    it "returns a hash representing the transaction object when given a withdrawal of 500 at 10/01/2012" do
      withdrawal = Transaction.new("10/01/2012", 500, "withdrawal")
      expect(withdrawal.make_hash).to eq({
        "date" => "10/01/2012",
        "amount" => 500,
        "type" => "withdrawal"
      })
    end

    it "returns a hash representing the transaction object when given a deposit of 1000 at 02/01/2012" do
      withdrawal = Transaction.new("02/01/2012", 1000, "deposit")
      expect(withdrawal.make_hash).to eq({
        "date" => "02/01/2012",
        "amount" => 1000,
        "type" => "deposit"
      })
    end
  end
end