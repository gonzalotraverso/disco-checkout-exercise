require_relative "item"
require "test/unit"

class ItemTest < Test::Unit::TestCase
  def test_code_validity
    assert_raise(ArgumentError) do
      Item.new('invalid')
    end
  end

  def test_code_is?
    item = Item.new(:GR1)

    assert(item.code_is?(:GR1))
    assert(item.code_is?('GR1'))
  end
end