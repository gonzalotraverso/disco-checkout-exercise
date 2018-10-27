require_relative 'item_types'

class Item
  def initialize(item_code)
    @item_type = get_type_by_code(item_code.to_s)
    raise ArgumentError, 'Code does not exist' if @item_type.nil?
  end

  def get_price
    @item_type[:price]
  end

  def get_formatted_price
    "£#{get_price}"
  end

  def get_name
    @item_type[:name]
  end

  def code_is?(code)
    @item_type[:code] == code.to_s
  end

  private
  def get_type_by_code(code)
    ITEM_TYPES.select { |type| type[:code] == code }.first
  end
end