# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
types = Type.create([{name: 'Income'}, {name: 'Expense'}])
incoming = Category.create([
                             { type: types.first, name: 'Salary'},
                             { type: types.first, name: 'Other Income'},
                             { type: types.first, name: 'Incoming transfer'},
                             { type: types.first, name: 'Collect interest'},
                             { type: types.first, name: 'Debt'}
                            ])
expenses = Category.create([
                             { type: types.second, name: 'Food & Beverage'}, #1
                             { type: types.second, name: 'Transportation'}, #2
                             { type: types.second, name: 'Rentals'}, #3
                             { type: types.second, name: 'Watter Bill'}, #4
                             { type: types.second, name: 'Phone Bill'}, #5
                             { type: types.second, name: 'Electricity Bill'}, #6
                             { type: types.second, name: 'Gas Bill'}, #7
                             { type: types.second, name: 'Television Bill'}, #8
                             { type: types.second, name: 'Internet Bill'}, #9
                             { type: types.second, name: 'Other Utility Bills'}, #10
                             { type: types.second, name: 'Home Maintenance'}, #11
                             { type: types.second, name: 'Vehicle Maintenance'}, #12
                             { type: types.second, name: 'Medical Check-up'}, #13
                             { type: types.second, name: 'Insurances'}, #14
                             { type: types.second, name: 'Education'}, #15
                             { type: types.second, name: 'Housewares'}, #16
                             { type: types.second, name: 'Personal Items'}, #17
                             { type: types.second, name: 'Pets'}, #18
                             { type: types.second, name: 'Home Services'}, #19
                             { type: types.second, name: 'Other Expense'}, #20
                             { type: types.second, name: 'Fitness'}, #21
                             { type: types.second, name: 'Makeup'}, #22
                             { type: types.second, name: 'Gifts & Donations'}, #23
                             { type: types.second, name: 'Streaming Service'}, #24
                             { type: types.second, name: 'Fun Money'}, #25
                             { type: types.second, name: 'Investment'}, #26
                             { type: types.second, name: 'Loan'}, #27
                             { type: types.second, name: 'Pay Interest'}, #28
                             { type: types.second, name: 'Outgoing transfer'} #29
                           ])

user = User.create({name: 'Eleazar Lopez', email: 'jaredtl023@gmail.com', password: '1234'})

wallets = Wallet.create([
                          {user: user, name: 'My first Wallet', active: 1},
                          {user: user, name: 'My second Wallet', active: 1},
                          {user: user, name: 'My third Wallet', active: 1}
                        ])

Transaction.create([
                     {wallet: wallets.first, category: expenses[21], description: 'Gym payment', amount: 120.0},
                     { wallet: wallets.first, category: expenses[22], description: 'Girlfriend Makeup', amount: 300.0},
                     { wallet: wallets.first, category: expenses[23], description: 'Twitch donation', amount: 15.0},
                     { wallet: wallets.first, category: expenses[24], description: 'Spotify', amount: 80.0},
                     { wallet: wallets.first, category: expenses[24], description: 'Disney+', amount: 60.0},
                     { wallet: wallets.first, category: expenses[24], description: 'Netflix', amount: 120.0},
                     { wallet: wallets.first, category: expenses[24], description: 'Amazon Prime', amount: 70.0},
                     { wallet: wallets.first, category: expenses[24], description: 'HBO Max', amount: 90.0}
                   ])

Transaction.create([
                     { wallet: wallets.first, category: incoming[1], description: 'Job 1 Salary', amount: 10000.0},
                     { wallet: wallets.first, category: incoming[1], description: 'Job 2 Salary', amount: 8500.0},
                     { wallet: wallets.first, category: incoming[2], description: 'Gift from my dad', amount: 350.0},
                     { wallet: wallets.first, category: incoming[3], description: 'Sale', amount: 80.0},
                     { wallet: wallets.first, category: incoming[3], description: 'Sale', amount: 60.0},
                     { wallet: wallets.first, category: incoming[3], description: 'Sale', amount: 120.0},
                     { wallet: wallets.first, category: incoming[5], description: 'Back loan', amount: 7000.0}
                   ])