require_relative "data/item_types"
require_relative "scanner"

class Checkout
  attr_reader :items

  def initialize(pricing_rules = [], scanner: Scanner.new(ITEM_TYPES))
    @items = {}
    @pricing_rules = pricing_rules
    @scanner = scanner
  end

  def scan(item_code)
    @items = @scanner.call(@items, item_code)
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
    format_money(add_discounts(subtotal))
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

  def format_money(number)
    "£#{number.round(2)}"
  end
end