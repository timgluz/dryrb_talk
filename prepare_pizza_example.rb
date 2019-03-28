require './app'

toppings = [
  {name: 'salami', quantity: 12},
  {name: 'mozzarella', quantity: 400}
]

puts "#-- Trying Hobbit size pizza:"

pizza_size = 5

p Services::PreparePizza.(size: pizza_size, toppings: toppings)

puts "\n\n\n#-- Ok, let's try Giant pizza then:"

pizza_size = 120

p Services::PreparePizza.(size: pizza_size, toppings: toppings)

puts "\n\n\n#-- Standard size pizza, but forget to add toppings"

pizza_size = 30
p Services::PreparePizza.(size: pizza_size, toppings: nil)


puts "\n\n\n#-- Standard pizza, add salami but forget to add quantity"
p Services::PreparePizza.(size: pizza_size, toppings: [{name: "z"}])

puts "\n\n\n#-- Happy flow:"

p Services::PreparePizza.(size: pizza_size, toppings: toppings)
