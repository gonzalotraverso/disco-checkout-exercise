require 'test_helper'

class ScannerTest < Minitest::Test
  def setup
    item_types = [
      { code: :IT1, name: 'Product', price: 3.6 },
      { code: :IT2, name: 'Product 2', price: 2.55 }
    ]
    @scanner = Scanner.new(item_types)
  end

  def test_scan
    basket = {}

    new_basket = @scanner.call(basket, :IT1)
    
    assert_equal(new_basket, { IT1: { count: 1, price: 3.6 } })
    
    new_basket = @scanner.call(basket, :IT1)
    
    assert_equal(new_basket, { IT1: { count: 2, price: 3.6 } })
    
    new_basket = @scanner.call(basket, :IT2)
    
    assert_equal(new_basket, { 
      IT1: { count: 2, price: 3.6 },
      IT2: { count: 1, price: 2.55 } 
    })
  end
end