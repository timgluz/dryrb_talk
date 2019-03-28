require './app'

cheese_toppings = [{name: 'mozzarella', quantity: 100}]

my_pizza = Services::PreparePizza.(size: 30, toppings: cheese_toppings).value!

puts "Forgot to put pizza in the oven"
p Services::BakePizza.(pizza: nil)

puts "\n\n\nBake Pizza in pre-heated stone oven"
p Services::BakePizza.(pizza: my_pizza)

