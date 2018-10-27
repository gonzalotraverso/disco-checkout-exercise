class Rule
  def initialize(apply_to: [], condition: proc { true }, discount:)
    @condition = condition
    @discount = discount
    @apply_to = apply_to
  end

  def call(items)
    filtered_items = filter_items(items)
    return 0 if filtered_items.empty? || !@condition.call(filtered_items)
    apply_discount(filtered_items)
  end
  
  private
  def filter_items(items)
    @apply_to.any? ? items.select { |key, value| @apply_to.include?(key) } : items
  end

  def apply_discount(items)
    @discount.call(items).round(2)
  end
end