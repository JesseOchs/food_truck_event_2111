require 'spec_helper'

describe Event do
  before :each do
    @event = Event.new('South Pearl Street Farmers Market')
    @food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    @food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    @food_truck3 = FoodTruck.new('Palisade Peach Shack')
    @item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    @item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
    @item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
    @item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
  end

  it 'exists and has attributes' do
    expect(@event).to be_a(Event)
    expect(@event.name).to eq('South Pearl Street Farmers Market')
    expect(@event.food_trucks).to eq([])
  end

  it 'can add food trucks' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
  end

  it 'can name the food trucks ' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_truck_names).to eq(['Rocky Mountain Pies', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'])
  end

  it 'can list food trucks that sell an item ' do
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
  end

  xit '' do
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expected = {
      :@item1 => {
        quanity: 100,
        food_trucks: [@food_truck1, @food_truck3]
      },
      :@item2 => {
        quanity: 7,
        food_trucks: [@food_truck1]
      },
      :@item3 => {
        quanity: 35,
        food_trucks: [@food_truck2, @food_truck3]
      },
      :@item4 => {
        quanity: 50,
        food_trucks: [@food_truck2]
      }
    }
    expect(@event.total_inventory).to eq(expected)
  end

  xit 'can list sorted items' do
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.sorted_item_list).to eq(['Apple Pie (Slice)', 'Banana Nice Cream', 'Peach Pie (Slice)',
                                           'Peach-Raspberry Nice Cream'])
  end
end
