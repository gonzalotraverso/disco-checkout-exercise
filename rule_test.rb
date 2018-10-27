require_relative "rule"
require "test/unit"

class RuleTest < Test::Unit::TestCase
  def test_buy_one_get_one_free
    # apply_to: item 1
    # condition: none
    # discount: for each item, the next one is free
    items = {
      IT1: { count: 3, price: 2.5 }
    }
    discount = proc do |items| 
      items.inject(0) { |total, (key, values)| total + (values[:count].to_i / 2) * values[:price] } 
    end
    rule = Rule.new(apply_to: [:IT1], discount: discount)

    assert_equal(rule.call(items), 2.5)
  end

  def test_bulk_buy_get_discount
    # apply_to: all items
    # condition: all items count greater than or equal to n (in this case 3)
    # discount: percent discount on all products (10% for this example)
    items = {
      IT1: { count: 1, price: 2.5 },
      IT2: { count: 3, price: 4 }
    }
    condition = proc do |items|
      items.inject(0) { |sum, (key, values)| sum + values[:count] } >= 3
    end
    discount = proc do |items|
      items.inject(0) { |total, (key, values)| total + ((values[:count] * values[:price]) * 0.1) }
    end
    rule = Rule.new(condition: condition, discount: discount)

    assert_equal(rule.call(items), 1.45)

    rule2 = Rule.new(apply_to: [:IT2], condition: condition, discount: discount)

    assert_equal(rule2.call(items), 1.2)
  end

  def test_rule_doesnt_apply
    items = {
      IT1: { count: 3, price: 2.5 }
    }
    discount = proc do |items| 
      items.inject(0) { |total, (key, values)| total + ((values[:count] * values[:price]) * 0.1) } 
    end
    rule = Rule.new(apply_to: [:IT2], discount: discount)

    assert_equal(rule.call(items), 0)
  end

  def test_condition_doesnt_apply
    items = {
      IT1: { count: 2, price: 2.5 }
    }
    condition = proc do |items|
      items.inject(0) { |sum, (key, values)| sum + values[:count] } > 3
    end
    discount = proc do |items| 
      items.inject(0) { |total, (key, values)| total + ((values[:count] * values[:price]) * 0.1) } 
    end
    rule = Rule.new(apply_to: [:IT1], discount: discount, condition: condition)

    assert_equal(rule.call(items), 0)
  end
end