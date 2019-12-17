class Transaction
  def initialize(date, amount, type)
    @date = date
    @amount = amount
    @type = type
  end

  # do we need this?

  def make_hash
    return {
      "date" => @date,
      "amount" => @amount,
      "type" => @type
    }
  end
end