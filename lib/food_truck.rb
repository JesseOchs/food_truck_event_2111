require 'item'
class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)

  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end


  def potential_revenue
      @inventory.keys.sum do |item|
        item.price * inventory[item]
      end
    end
    
end
