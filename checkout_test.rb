require "test/unit"
require_relative "checkout"
require_relative "rule"
require_relative "rule/buy_one_get_one_free"
require_relative "rule/buy_bulk_get_discount"

class CheckoutTest < Test::Unit::TestCase
  def test_scan_item
    checkout = Checkout.new

    checkout.scan(:GR1)

    assert_equal(checkout.get_item_count(:GR1), 1)

    checkout.scan(:GR1)

    assert_equal(checkout.get_item_count(:GR1), 2)
  end

  def test_get_total
    checkout = Checkout.new

    checkout.scan(:GR1)
    checkout.scan(:GR1)
    checkout.scan(:SR1)

    assert_equal(checkout.total, 11.22)
  end

  def test_scan_multiple
    checkout = Checkout.new

    checkout.scan_multiple(:GR1, :SR1)

    assert_equal(checkout.get_item_count(:GR1), 1)
    assert_equal(checkout.get_item_count(:SR1), 1)
  end

  def test_case1
    checkout = Checkout.new(rules)

    checkout.scan_multiple(:GR1, :SR1, :GR1, :GR1, :CF1)

    assert_equal(checkout.total, 22.45)
  end

  def test_case2
    checkout = Checkout.new(rules)

    checkout.scan_multiple(:GR1, :GR1)

    assert_equal(checkout.total, 3.11)
  end

  def test_case3
    checkout = Checkout.new(rules)

    checkout.scan_multiple(:SR1, :SR1, :GR1, :SR1)

    assert_equal(checkout.total, 16.61)
  end

  def test_case4
    checkout = Checkout.new(rules)

    checkout.scan_multiple(:GR1, :CF1, :SR1, :CF1, :CF1)

    assert_equal(checkout.total, 30.57)
  end

  private
  def rules
    @rules ||= [
      Rule::BuyOneGetOneFree.new.call([:GR1]),
      Rule::BuyBulkGetDiscount.new.call([:SR1], 3, 0.1),
      Rule::BuyBulkGetDiscount.new.call([:CF1], 3, (1/3.0))
    ]
  end
end

#rules : buy one get one free
# buy n or more of x get discount on x