require './app'

small_size = 30
hawaii_toppings = [
  {name: 'tuna', quantity: 50},
  {name: 'pineapples', quantity: 80}
]

p "#-- Let's try my favorite pizza"
p Services::CreatePizzaFlow.(size: small_size, toppings: hawaii_toppings)


classic_toppings = [
  {name: 'salami', quantity: 50},
  {name: 'pastrami', quantity: 50},
  {name: 'mozzarella', quantity: 50}
]

exit 0


p "#-- OK, let's do full-scale demo"
order = {
  size: small_size,
  toppings: classic_toppings
}

# initializing the flow
pizza_creation_flow = Services::CreatePizzaFlow.new

# initializing flow observers
branch_manager = Services::BranchManagerObserver.new
delivery_person = Services::DeliveryObserver.new


# register listeners to the steps flow
pizza_creation_flow.subscribe(branch_manager)
pizza_creation_flow.subscribe(delivery_person)

# Action?
p pizza_creation_flow.call(**order)
