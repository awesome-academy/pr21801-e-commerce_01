# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "admin", email: "admin@gmail.com", role: true, phone: "123456", address: "address",
  password: ENV["ADMIN_PASSWORD"]
)

User.create!(name: "Tùng", email: "tung@gmail.com", phone: "123456", address: "address", password: "123456")
User.create!(name: "Trung", email: "trung@gmail.com", phone: "123456", address: "address", password: "123456")
User.create!(name: "Long", email: "long@gmail.com", phone: "123456", address: "address", password: "123456")
User.create!(name: "Đăng", email: "dang@gmail.com", phone: "123456", address: "address", password: "123456")
User.create!(name: "Hương", email: "huong@gmail.com", phone: "123456", address: "address", password: "123456")
User.create!(name: "Hùng", email: "hung@gmail.com", phone: "123456", address: "address", password: "123456")

# Category.create!(
#   name: "First category", description: "creted from seeds.rb", parent_id: nil
# )
