# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'nokogiri'

# Seeding coaches

coaches = []

coach1_info = {name: 'Coach Daniel', email: 'coachdaniel@email.com', password:11111111, contact_number: '11111111', date_of_birth:"1 Jan 01", admin:'true', gender: 'male'}
coach1 = User.new(coach1_info)
coach1.save!

coaches << coach1

coach2_info = {name: 'Coach Michelle', email: 'coachmichelle@email.com', password:22222222, contact_number: '22222222', date_of_birth:"2 Feb 02", gender: 'female'}
coach2 = User.new(coach2_info)
coach2.save!

coaches << coach2

puts 'seeded 2 coaches'

38.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '11111111' ,
    contact_number: Faker::PhoneNumber.cell_phone_in_e164,
    date_of_birth: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    gender: ['male', 'female'].sample
  )
  user.save!
  coaches << user
end

puts 'seeded 38 random users (coaches)'

# Seeding sports

sport1 = Sport.new(name: 'golf', picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1642427165/sportmelite/ben-hogan_tpcqgt.jpg')
sport1.save!

sport2 = Sport.new(name: "badminton", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640173203/sportmelite/pexels-salman-hossain-saif-6742706_nj57kw.jpg')
sport2.save!

sport3 = Sport.new(name: "tennis", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640173019/sportmelite/jim-sung-eQuMbR-0mco-unsplash_qljsh7.jpg')
sport3.save!

sport4 = Sport.new(name: "kickboxing", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1642427399/sportmelite/justin-ng-45tcVh0M3kw-unsplash_mrt85e.jpg')
sport4.save!

sport5 = Sport.new(name: "swimming", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640172999/sportmelite/jorge-romero-mfCFuPfTtdU-unsplash_dwjdjm.jpg')
sport5.save!

puts 'seeded 5 sports'

# Seeding coach profiles

coach_photo_url = ['https://s3.amazonaws.com/dev-wordpress-json/Akin.jpg', 'https://s3.amazonaws.com/dev-wordpress-json/Angela.jpg','https://s3.amazonaws.com/dev-wordpress-json/Ugo.jpg','https://s3.amazonaws.com/dev-wordpress-json/Jaws.jpg','https://s3.amazonaws.com/dev-wordpress-json/Sophia1.jpg','https://s3.amazonaws.com/dev-wordpress-json/Yavuz1.jpg','https://s3.amazonaws.com/dev-wordpress-json/Chandler.jpg', 'https://www.cru68.com/assets/uploads/packleaders/4ca1c08de29df60e656c01cf3fe54f4b.png', 'https://www.cru68.com/assets/uploads/packleaders/2b040b104d29925ba56d55da17e6fbc8.jpg', 'https://www.cru68.com/assets/uploads/packleaders/447d278d71efa0d3214e9ca6c632fb8e.png', 'https://www.cru68.com/assets/uploads/packleaders/04f829c5864727c600eed4ae5038507c.jpg', 'https://www.cru68.com/assets/uploads/packleaders/eee3cb4495f0addfbb9d71b0ff65ce6b.jpg', 'https://www.cru68.com/assets/uploads/packleaders/f3c6c7b5aa285864ae0041cd78747f80.png']

require "open-uri"

golf_coaches = coaches.first(8)

golf_coaches.each do |user|
  coach = CoachProfile.new(
    coach_start_date: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
    user_id: user.id,
    sport_id: 1,
    photo_key: coach_photo_url.sample
  )
  coach.save!
end

puts 'seeded 8 golf coach profiles'

badminton_coaches = coaches[9..16]

badminton_coaches.each do |user|
  coach = CoachProfile.new(
    coach_start_date: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
    user_id: user.id,
    sport_id: 2,
    photo_key: coach_photo_url.sample
  )
  coach.save!
end

puts 'seeded 8 badminton coach profiles'

tennis_coaches = coaches[17..24]

tennis_coaches.each do |user|
  coach = CoachProfile.new(
    coach_start_date: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
    user_id: user.id,
    sport_id: 3,
    photo_key: coach_photo_url.sample
  )
  coach.save!
end

puts 'seeded 8 tennis coach profiles'

kickboxing_coaches = coaches[25..32]

kickboxing_coaches.each do |user|
  coach = CoachProfile.new(
    coach_start_date: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
    user_id: user.id,
    sport_id: 4,
    photo_key: coach_photo_url.sample
  )
  coach.save!
end

puts 'seeded 8 kickboxing coach profiles'

swimming_coaches = coaches[33..40]

swimming_coaches.each do |user|
  coach = CoachProfile.new(
    coach_start_date: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
    user_id: user.id,
    sport_id: 5,
    photo_key: coach_photo_url.sample
  )
  coach.save!
end

puts 'seeded 8 swimming coach profiles'

# seeding students

student1_info = {name: 'John Lim', email: 'johnlim@email.com', password:11111111, contact_number: '11111111', date_of_birth:"1 Jan 01", admin:'true', gender: 'male'}
student1 = User.new(student1_info)
student1.save!

student2_info = {name: 'Sarah Tan', email: 'sarahtan@email.com', password:22222222, contact_number: '22222222', date_of_birth:"2 Feb 02", gender: 'female'}
student2 = User.new(student2_info)
student2.save!

8.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '11111111',
    contact_number: Faker::PhoneNumber.cell_phone_in_e164,
    date_of_birth: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    gender: ['male', 'female'].sample
  )
  user.save!
end

puts 'seeded 10 users (students)'

# Seeding lessons
require 'date'

doc = Nokogiri::XML(File.open("#{Rails.root}/lib/tasks/1.DUS_School_Sports_Facilities.kml")) # it works
# doc = Nokogiri::XML(File.open("2.PLAYSG.kml")) # it works
# doc = Nokogiri::XML(File.open("3.sportsg-dus-sport-facilities-kml.kml")) # it does not work
# doc = Nokogiri::XML(File.open("4.sportsg-sport-facilities-kml.kml")) # it does not work
# doc = Nokogiri::XML(File.open("5.AQUATICSG.kml")) # it works

location_array = doc.css('Placemark')
location_array.each do |location|
  coordinate = location.css('Point coordinates').text.split(",") #getting all the cooridinates
  labels = {}
  labels[:name] = location.css('name').text
  labels[:long] = coordinate[0].to_f
  labels[:lat] = coordinate[1].to_f
  description = Nokogiri::XML(location.css('description')[0])

  description.css('td').each {|node|

    if node.text == "ADDRESSPOSTALCODE"
      labels[:postalcode] = node.next_element.text
    elsif node.text == "ADDRESSBUILDINGNAME" || node.text == "ADDRESSSTREETNAME"
      labels[:address] = node.next_element.text
    elsif node.text == "DESCRIPTION"
      labels[:description] = node.next_element.text
    elsif node.text == "Sports"
      labels[:sport] = node.next_element.text
    end
  }
  location = Location.new(labels)
  next unless location.save
  # p '------------------------------------------------------------'
end

puts 'seed all location from 1.DUS_School_Sports_Facilities.kml'
 # Seeding booked lessons

300.times do |i|
  year = [2022].sample
  month = rand(1..12)
  day = rand(1..7)
  hour = rand(7..20)
  coach = User.select(&:coach_profile).sample
  location = Location.all.sample
  lesson = Lesson.new({
    start_date_time: DateTime.new(year,month,day,hour).new_offset(0),
    end_date_time: DateTime.new(year,month,day,hour+1).new_offset(0),
    location: location,
    price: rand(40..80),
    status: true,
    student_id: rand(41..50),
    coach: coach,
    description: "#{coach.sport.name.capitalize} Lesson (#{location.name})"
  })
  lesson.save!
end

puts 'seeded 200 random booked lessons'

 # Seeding available lessons

coach_array = (5..12).to_a + (22..42).to_a

300.times do |i|
  year = [2022].sample
  month = rand(1..12)
  day = rand(1..7)
  hour = rand(7..20)
  coach = User.select(&:coach_profile).sample
  location = Location.all.sample
  lesson = Lesson.new({
    start_date_time: DateTime.new(year,month,day,hour).new_offset(0),
    end_date_time: DateTime.new(year,month,day,hour+1).new_offset(0),
    location: location,
    price: rand(5..50),
    status: false,
    coach: coach,
    description: "#{coach.sport.name.capitalize} Lesson (#{location.name})"
  })
  lesson.save!
end

puts 'seeded 200 random available lessons'

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

500.times do
  Order.create({
    state: "paid",
    amount_cents: rand(500..5000),
    checkout_session_id: 'cs_test_a1Y8rmMSjqJeMUZNfU2drWfJdGlG7c75WBobJYBV7nvnxAqx7J6mf5lEP' + rand(0..9).to_s,
    user_id: rand(41..50),
    lesson_id: rand(1..400),
    created_at: rand_time(20.days.ago),
    updated_at: rand_time(20.days.ago)
  })
end

puts 'seeded 300 random paid orders'

500.times do
  Review.create({
    content: "'#{Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2)}' - #{Faker::Name.name}",
    lesson_id: rand(1..200),
    student_id: rand(41..50),
    created_at: rand_time(20.days.ago),
    updated_at: rand_time(20.days.ago),
    rating: rand(1..5)
  })
end

puts 'seeded 300 random reviews'
