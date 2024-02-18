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

space1 = Space.create(owner: creator, description: 'My Space', user_ids: [member1.id])
_space2 = Space.create(owner: creator, description: 'My Space', user_ids: [])

# 100.times.each do |time|
#   Space.create(owner: [superadmin, admin, creator, member1, member2].sample,
#                description: generate_sku(excluded: Space.pluck(:description)),
#                user_ids: [[superadmin, admin, creator, member1, member2].sample.id])
# end

Link.create(space: space1, owner: creator)

100.times.each do |time|
  Supplier.create(name: Faker::Company.name,
                  space: space1)
end

supplier_ids = Supplier.pluck(:id)

100.times.each do |time|
  Item.create(description: Faker::Food.ingredient,
              space: space1,
              supplier_id: supplier_ids.sample,
              actual_quantity: (2..100).to_a.sample,
              expected_quantity: (2..100).to_a.sample)
end

100.times.each do |time|
  Order.create(space: space1)
end
