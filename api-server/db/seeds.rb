# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Match.create([
  { player1: 'Jason', player2: 'Hello', matchWon: true },
  { player1: 'Tim', player2: 'Now', matchWon: true },
  { player1: 'Zach', player2: 'Never', matchWon: false },
  { player1: 'Matt', player2: 'Wow', matchWon: true },
])