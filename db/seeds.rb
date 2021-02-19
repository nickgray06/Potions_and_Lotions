Order.destroy_all
Sorcerer.destroy_all
Item.destroy_all


sorcerer1 = Sorcerer.create(name:"Mordecai", skill:"fire")
sorcerer2 = Sorcerer.create(name:"Gandalf", skill:"lightning")

item1 = Item.create(name:"Eye of Newt".green, ability:"Turns you into a stupid frog", rarity: 2, cast_cost: 50, price: 18.29)
item2 = Item.create(name:"Amulet of the Drunkard", ability:"For Friday nights.", rarity: 8, cast_cost:1000000, price: 45.45)
item3 = Item.create(name:"Broom of Flying", ability:"Gets you up there.", rarity: 5, cast_cost: 22, price: 13.00)

Order.create(sorcerer: sorcerer1, item: item1)
Order.create(sorcerer: sorcerer2, item: item2)
Order.create(sorcerer: sorcerer2, item: item1)