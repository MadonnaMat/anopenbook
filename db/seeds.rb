# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..10).each do |num|
  user = User.new(
    username: "testuser#{num}",
    email: "testuser#{num}@test.com",
    password: '123456',
    password_confirmation: '123456',
    fullname: "Test User #{num}"
  )
  user.skip_confirmation!
  user.save!
end

Book.genres.each do |genre, val|
  Book.create(genre: val,
              title: 'Manuscript',
              current_step: Book.current_steps[:synopsis_submission],
              current_step_ends_at: 5.years.from_now,
              read_count: 0)
  (1..20).each do |num|
    Book.create(genre: val,
                title: "#{genre.titleize} Book #{num}",
                current_step: Book.current_steps[:complete],
                current_step_ends_at: 1.day.ago,
                read_count: rand(80))
  end
end
