class Rule::BuyBulkGetDiscount
  def call(codes, bulk_size, discount_percent)
    condition = proc do |items|
      result = items.inject(0) { |sum, (key, values)| sum + values[:count] } >= bulk_size
    end
    discount = proc do |items|
      items.inject(0) do |total, (key, values)| 
        total + ((values[:count] * values[:price]) * discount_percent) 
      end
    end
    Rule.new(apply_to: codes, discount: discount, condition: condition)
  end
end