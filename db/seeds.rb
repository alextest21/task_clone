# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['First course', 'Main course', 'Drinks'].each do |name|
  Category.find_or_create_by({name: name})
end
['Travelata', 'Coral Travel', 'Tez Tour'].each do |name|
  Organization.find_or_create_by({name: name})
end
ApiKey.create
