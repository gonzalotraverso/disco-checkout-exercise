class Scanner
  def initialize(item_types)
    @item_types = item_types
  end

  def call(basket, item_code)
    code = item_code.to_sym
    item = find_item_by_code(code)
    add_item_to_basket(basket, item, code)
  end

  private
  def find_item_by_code(code)
    item = @item_types.select { |item| item[:code] == code }[0]
    raise ArgumentError, "invalid code" if item.nil?
    item
  end

  def add_item_to_basket(basket, item, code)
    basket[code] = {
      price: item[:price],
      count: (basket.dig(code, :count) || 0) + 1
    }
    basket
  end
end