require 'spec_helper'

describe FoodTruck do
  before :each do
    @food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    @food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    @food_truck3 = FoodTruck.new('Palisade Peach Shack')
    @item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    @item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
    @item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
    @item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
  end

  it 'exists and has attributes' do
    expect(@food_truck1).to be_a(FoodTruck)
    expect(@food_truck1.name).to eq('Rocky Mountain Pies')
    expect(@food_truck1.inventory).to eq({})
  end

  it 'can check stocked items' do
    expect(@food_truck1.check_stock(@item1)).to eq(0)
  end

  it 'can check stock items' do
    @food_truck1.stock(@item1, 30)
    expect(@food_truck1.check_stock(@item1)).to eq(30)
    @food_truck1.stock(@item1, 25)
    expect(@food_truck1.check_stock(@item1)).to eq(55)
  end

  it 'can stock items and check inventory' do
    @food_truck1.stock(@item1, 30)
    @food_truck1.stock(@item1, 25)
    @food_truck1.stock(@item2, 12)
    expected = {
      @item1 => 55,
      @item2 => 12
    }
    expect(@food_truck1.inventory).to eq(expected)
  end

  it 'can calculate potential revenue' do
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    expect(@food_truck1.potential_revenue).to eq(148.75)
    expect(@food_truck2.potential_revenue).to eq(345.00)
    expect(@food_truck3.potential_revenue).to eq(243.75)
  end
end
