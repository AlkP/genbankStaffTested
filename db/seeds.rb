# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!( username: 'admin', email: 'admin@test.com', initials: 'Админ предприятия', password: 'admin', password_confirmation: 'admin', role: :admin )
User.create!( username: 'manager', email: 'manager@test.com', initials: 'Менеджер предприятия', password: 'manager', password_confirmation: 'manager', role: :manager )
User.create!( username: 'user', email: 'user@test.com', initials: 'Пользователь предприятия', password: 'user', password_confirmation: 'user', role: :user )
