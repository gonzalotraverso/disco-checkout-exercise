class Rule::BuyOneGetOneFree
  def call(codes)
    discount = proc do |items| 
      items.inject(0) { |total, (key, values)| total + (values[:count].to_i / 2) * values[:price] } 
    end
    Rule.new(apply_to: codes, discount: discount)
  end
end