# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'nokogiri'

# Seeding users

student1_info = {name: 'student1', email: 'student1@email.com', password:11111111, contact_number: '11111111', date_of_birth:"1 Jan 01", admin:'true', gender: 'male'}
student1 = User.new(student1_info)
student1.save!

student2_info = {name: 'student2', email: 'student2@email.com', password:22222222, contact_number: '22222222', date_of_birth:"2 Feb 02", gender: 'male'}
student2 = User.new(student2_info)
student2.save!

student3_info = {name: 'student3', email: 'student3@email.com', password:33333333, contact_number: '33333333', date_of_birth:"3 Mar 03", gender: 'male'}
student3 = User.new(student3_info)
student3.save!

student4_info = {name: 'student4', email: 'student4@email.com', password:44444444, contact_number: '44444444', date_of_birth:"4 Apr 04", gender: 'male'}
student4 = User.new(student4_info)
student4.save!

coach1_info = {name: 'coach1', email: 'coach1@email.com', password:11111111, contact_number: '11111111', date_of_birth:"1 Jan 01", admin:'true', gender: 'female'}
coach1 = User.new(coach1_info)
coach1.save!

coach2_info = {name: 'coach2', email: 'coach2@email.com', password:22222222, contact_number: '22222222', date_of_birth:"2 Feb 02", gender: 'female'}
coach2 = User.new(coach2_info)
coach2.save!

coach3_info = {name: 'coach3', email: 'coach3@email.com', password:33333333, contact_number: '33333333', date_of_birth:"3 Mar 03", gender: 'female'}
coach3 = User.new(coach3_info)
coach3.save!

coach4_info = {name: 'coach4', email: 'coach4@email.com', password:44444444, contact_number: '44444444', date_of_birth:"4 Apr 04", gender: 'female'}
coach4 = User.new(coach4_info)
coach4.save!

coach5_info = {name: 'coach5', email: 'coach5@email.com', password:55555555, contact_number: '55555555', date_of_birth:"5 Jan 05", gender: 'female'}
coach5 = User.new(coach5_info)
coach5.save!

coach6_info = {name: 'coach6', email: 'coach6@email.com', password:66666666, contact_number: '66666666', date_of_birth:"6 Feb 06", gender: 'female'}
coach6 = User.new(coach6_info)
coach6.save!

coach7_info = {name: 'coach7', email: 'coach7@email.com', password:77777777, contact_number: '77777777', date_of_birth:"7 Mar 07", gender: 'female'}
coach7 = User.new(coach7_info)
coach7.save!

coach8_info = {name: 'coach8', email: 'coach8@email.com', password:88888888, contact_number: '88888888', date_of_birth:"8 Apr 08", gender: 'male'}
coach8 = User.new(coach8_info)
coach8.save!

puts 'seeded 4 students and 8 coaches'

users = []

30.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '11111111' ,
    contact_number: Faker::PhoneNumber.cell_phone_in_e164,
    date_of_birth: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    gender: ['male', 'female'].sample
  )
  user.save!
  users << user
end

puts 'seeded 30 random users'

# Seeding sports

sport1 = Sport.new(name: 'soccer', picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640172927/sportmelite/dim-hou-cMYFJ95TY_E-unsplash_tekwc4.jpg')
sport1.save!

sport2 = Sport.new(name: "badminton", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640173203/sportmelite/pexels-salman-hossain-saif-6742706_nj57kw.jpg')
sport2.save!

sport3 = Sport.new(name: "tennis", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640173019/sportmelite/jim-sung-eQuMbR-0mco-unsplash_qljsh7.jpg')
sport3.save!

sport4 = Sport.new(name: "basketball", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640173254/sportmelite/ian-simmonds-dU8nD7GBuXY-unsplash_1_zjibp6.jpg')
sport4.save!

sport5 = Sport.new(name: "swimming", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1640172999/sportmelite/jorge-romero-mfCFuPfTtdU-unsplash_dwjdjm.jpg')
sport5.save!

puts 'seeded 5 sports'

# Seeding coach profiles

coach_photo_url = ['https://s3.amazonaws.com/dev-wordpress-json/Akin.jpg', 'https://s3.amazonaws.com/dev-wordpress-json/Angela.jpg','https://s3.amazonaws.com/dev-wordpress-json/Ugo.jpg','https://s3.amazonaws.com/dev-wordpress-json/Jaws.jpg','https://s3.amazonaws.com/dev-wordpress-json/Sophia1.jpg','https://s3.amazonaws.com/dev-wordpress-json/Yavuz1.jpg','https://s3.amazonaws.com/dev-wordpress-json/Chandler.jpg', 'https://www.cru68.com/assets/uploads/packleaders/4ca1c08de29df60e656c01cf3fe54f4b.png', 'https://www.cru68.com/assets/uploads/packleaders/2b040b104d29925ba56d55da17e6fbc8.jpg', 'https://www.cru68.com/assets/uploads/packleaders/447d278d71efa0d3214e9ca6c632fb8e.png', 'https://www.cru68.com/assets/uploads/packleaders/04f829c5864727c600eed4ae5038507c.jpg', 'https://www.cru68.com/assets/uploads/packleaders/eee3cb4495f0addfbb9d71b0ff65ce6b.jpg', 'https://www.cru68.com/assets/uploads/packleaders/f3c6c7b5aa285864ae0041cd78747f80.png']

coach_profile1 = CoachProfile.new({
  coach_start_date: DateTime.new(2010,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 5,
  sport_id: 1,
  photo_key: coach_photo_url.sample
})
# coach_profile1.photos.key = coach_photo_keys.sample
coach_profile1.save!

coach_profile2 = CoachProfile.new({
  coach_start_date: DateTime.new(2011,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 6,
  sport_id: 2,
  photo_key: coach_photo_url.sample
})
coach_profile2.save!

coach_profile3 = CoachProfile.new({
  coach_start_date: DateTime.new(2012,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 7,
  sport_id: 3,
  photo_key: coach_photo_url.sample
})
coach_profile3.save!

coach_profile4 = CoachProfile.new({
  coach_start_date: DateTime.new(2013,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 8,
  sport_id: 4,
  photo_key: coach_photo_url.sample
})
coach_profile4.save!

coach_profile5 = CoachProfile.new({
  coach_start_date: DateTime.new(2010,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 9,
  sport_id: 1,
  photo_key: coach_photo_url.sample
})
coach_profile5.save!

coach_profile6 = CoachProfile.new({
  coach_start_date: DateTime.new(2011,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 10,
  sport_id: 2,
  photo_key: coach_photo_url.sample
})
coach_profile6.save!

coach_profile7 = CoachProfile.new({
  coach_start_date: DateTime.new(2012,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 11,
  sport_id: 3,
  photo_key: coach_photo_url.sample
})
coach_profile7.save!

coach_profile8 = CoachProfile.new({
  coach_start_date: DateTime.new(2013,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 12,
  sport_id: 4,
  photo_key: coach_photo_url.sample
})
coach_profile8.save!

puts 'seeded 8 coach profiles'

require "open-uri"

coaches = users.last(20)

coaches.each do |user|
  coach = CoachProfile.new(
    coach_start_date: Faker::Date.between(from: '1980-09-23', to: '2014-09-25'),
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
    user_id: user.id,
    sport_id: rand(1..5),
    photo_key: coach_photo_url.sample
  )
  # file = URI.open('https://res.cloudinary.com/dcwfy3dua/image/upload/v1639193524/sportmelite/coach%20profile%20pic/drive-download-20211211T033126Z-001/000003_jqa1m9.jpg')
  # coach.photos.attach(io: file, filename: 'test.png', content_type:'image/png')
  coach.save!
end

puts 'seeded 20 random coach profiles'

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

 coach_array = (5..12).to_a + (22..42).to_a

200.times do |i|
  year = [2021, 2022].sample
  month = rand(1..12)
  day = rand(1..7)
  hour = rand(7..20)
  lesson1 = Lesson.new({
    start_date_time: DateTime.new(year,month,day,hour).new_offset(0),
    end_date_time: DateTime.new(year,month,day,hour+1).new_offset(0),
    location: Location.all.sample,
    price: rand(5..50),
    status: true,
    student_id: rand(1..42),
    coach: User.select(&:coach_profile).sample,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  })
  lesson1.save!
end

puts 'seeded 200 random booked lessons'

 # Seeding available lessons

coach_array = (5..12).to_a + (22..42).to_a

200.times do |i|
  year = [2022, 2023, 2024].sample
  month = rand(1..12)
  day = rand(1..7)
  hour = rand(7..20)
  lesson1 = Lesson.new({
    start_date_time: DateTime.new(year,month,day,hour).new_offset(0),
    end_date_time: DateTime.new(year,month,day,hour+1).new_offset(0),
    location: Location.all.sample,
    price: rand(5..50),
    status: false,
    coach: User.select(&:coach_profile).sample,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  })
  lesson1.save!
end

puts 'seeded 200 random available lessons'

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

300.times do
  Order.create({
    state: "paid",
    amount_cents: rand(500..5000),
    checkout_session_id: 'cs_test_a1Y8rmMSjqJeMUZNfU2drWfJdGlG7c75WBobJYBV7nvnxAqx7J6mf5lEP' + rand(0..9).to_s,
    user_id: rand(1..42),
    lesson_id: rand(1..400),
    created_at: rand_time(10.days.ago),
    updated_at: rand_time(10.days.ago)
  })
end

puts 'seeded 300 random paid orders'

300.times do
  Review.create({
    content: "'#{Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2)}' - #{Faker::Name.name}",
    lesson_id: rand(1..200),
    student_id: rand(1..42),
    created_at: rand_time(10.days.ago),
    updated_at: rand_time(10.days.ago),
    rating: rand(1..5)
  })
end

puts 'seeded 300 random reviews'
