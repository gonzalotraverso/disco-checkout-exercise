class Rule
  def initialize(apply_to: [], condition: proc { true }, discount:)
    @condition = condition
    @discount = discount
    @apply_to = apply_to
  end

  def call(items)
    filtered_items = filter_items(items)
    apply_dicount(items) if @condition.call(filtered_items)
  end
  
  private
  def filter_items(items)
    @apply_to.any? ? items.select { |key, value| @apply_to.include?(key) } : items
  end

  def apply_dicount(items)
    @discount.call(items).round(2)
  end
end