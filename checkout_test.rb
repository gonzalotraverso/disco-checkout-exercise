require "test/unit"
require_relative "checkout"

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

  # def test_case1
  #   checkout = Checkout.new(rules)

  #   checkout.scan_multiple(:GR1, :SR1, :GR1, :GR1, :CF1)

  #   assert_equal(checkout.total, 22.45)
  # end
end

#rules : buy one get one free
# buy n or more of x get discount on x