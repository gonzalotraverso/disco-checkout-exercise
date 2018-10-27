require_relative "data/item_types"

class Checkout
  attr_reader :items

  def initialize(pricing_rules = [])
    @items = {}
    @pricing_rules = pricing_rules
  end

  def scan(item_code)
    code = item_code.to_sym
    item = find_item_by_code(code)
    add_item_to_basket(item, code)
  end

  def scan_multiple(*items)
    items.each { |item| scan(item) }
  end

  def subtotal
    @items.inject(0) do |sum, (code, values)| 
      sum + (values[:price] * values[:count])
    end
  end

  def total
    add_discounts(subtotal).round(2)
  end
  
  def get_item(code)
    @items[code.to_sym]
  end
  
  def get_item_count(code)
    get_item(code)[:count]
  end
  
  private
  def add_discounts(subtotal)
    @pricing_rules.inject(subtotal) { |total, rule| total - rule.call(@items) }
  end

  def find_item_by_code(code)
    item = ITEM_TYPES.select { |item| item[:code] == code }[0]
    raise ArgumentError, "invalid code" if item.nil?
    item
  end

  def add_item_to_basket(item, code)
    @items[code] = {
      price: item[:price],
      count: (@items.dig(code, :count) || 0) + 1
    }
  end
end