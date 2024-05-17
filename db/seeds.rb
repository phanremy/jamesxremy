# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
include Sku

superadmin =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'superadmin@example.com', admin: true)
admin =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'admin@example.com', admin: true)
creator =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'user1@example.com')
member1 =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'user2@example.com')
member2 =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'user3@example.com')
_visitor =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'visitor@example.com', confirmed: false)

_post1 = Post.create(title: 'SuperAdmin\'s first post', body: 'This is the first post of the super admin', user: superadmin)
_post2 = Post.create(title: 'Admin\'s first post', body: 'This is the first post of the admin', user: admin)

# 100.times.each do |time|
#   Post.create(user: [superadmin, admin, creator, member1, member2].sample,
#               title: Faker::Creature::Animal.name,
#               body: generate_sku(excluded: Space.pluck(:description)))
# end

space1 = Space.create(owner: creator, description: 'Mon Restaurant', user_ids: [member1.id], extra_units: ['L', 'g'])
_space2 = Space.create(owner: creator, description: 'Mon Restaurant', user_ids: [])

# 100.times.each do |time|
#   Space.create(owner: [superadmin, admin, creator, member1, member2].sample,
#                description: generate_sku(excluded: Space.pluck(:description)),
#                user_ids: [[superadmin, admin, creator, member1, member2].sample.id])
# end

Link.create(space: space1, owner: creator)

# 100.times.each do |time|
#   Supplier.create(name: Faker::Company.name.split(/[ ,]/).first,
#                   space: space1,
#                   expected_day: (1..6).to_a.sample,
#                   expected_week: (0..1).to_a.sample,
#                   expected_month: 0)
# end

# supplier_ids = Supplier.pluck(:id)

# 100.times.each do |time|
#   Item.create(description: Faker::Food.ingredient,
#               reference: (10000..99999).to_a.sample,
#               space: space1,
#               supplier_id: supplier_ids.sample,
#               price: (10..99).to_a.sample.fdiv(10),
#               actual_quantity: (2..100).to_a.sample,
#               unit: Item::UNITS.sample,
#               expected_quantity: (2..100).to_a.sample)
# end

# Supplier.all.each do |supplier|
#   Order.create(space: space1, supplier:)
# end

# 100.times.each do |time|
#   Product.create(description: Faker::Food.dish,
#                  space: space1,
#                  price: (100..300).to_a.sample.fdiv(10),
#                  sales_count: (0..99).to_a.sample)
# end

# product_ids = Product.pluck(:id)
# item_ids = Item.pluck(:id)

# 200.times.each do |time|
#   ProductItem.create(product_id: product_ids.sample,
#                      item_id: item_ids.sample,
#                      gross_quantity: (1..5).to_a.sample,
#                      net_quantity: (1..5).to_a.sample,
#                      quantity_ratio: (1..9).to_a.sample.fdiv(10))
# end

# 5.times.each do |time|
#   Sale.create(space: space1,
#               final_amount_inc_tax: 90,
#               final_amount_exc_tax: 100,
#               details: { key: 'value'})
# end
