# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Seeding users

student1_info = {name: 'student1', email: 'student1@email.com', password:11111111, contact_number: '11111111', date_of_birth:"1 Jan 01"}
student1 = User.new(student1_info)
student1.save!

student2_info = {name: 'student2', email: 'student2@email.com', password:22222222, contact_number: '22222222', date_of_birth:"2 Feb 02"}
student2 = User.new(student2_info)
student2.save!

student3_info = {name: 'student3', email: 'student3@email.com', password:33333333, contact_number: '33333333', date_of_birth:"3 Mar 03"}
student3 = User.new(student3_info)
student3.save!

student4_info = {name: 'student4', email: 'student4@email.com', password:44444444, contact_number: '44444444', date_of_birth:"4 Apr 04"}
student4 = User.new(student4_info)
student4.save!

coach1_info = {name: 'coach1', email: 'coach1@email.com', password:11111111, contact_number: '11111111', date_of_birth:"1 Jan 01"}
coach1 = User.new(coach1_info)
coach1.save!

coach2_info = {name: 'coach2', email: 'coach2@email.com', password:22222222, contact_number: '22222222', date_of_birth:"2 Feb 02"}
coach2 = User.new(coach2_info)
coach2.save!

coach3_info = {name: 'coach3', email: 'coach3@email.com', password:33333333, contact_number: '33333333', date_of_birth:"3 Mar 03"}
coach3 = User.new(coach3_info)
coach3.save!

coach4_info = {name: 'coach4', email: 'coach4@email.com', password:44444444, contact_number: '44444444', date_of_birth:"4 Apr 04"}
coach4 = User.new(coach4_info)
coach4.save!

coach5_info = {name: 'coach5', email: 'coach5@email.com', password:55555555, contact_number: '55555555', date_of_birth:"5 Jan 05"}
coach5 = User.new(coach5_info)
coach5.save!

coach6_info = {name: 'coach6', email: 'coach6@email.com', password:66666666, contact_number: '66666666', date_of_birth:"6 Feb 06"}
coach6 = User.new(coach6_info)
coach6.save!

coach7_info = {name: 'coach7', email: 'coach7@email.com', password:77777777, contact_number: '77777777', date_of_birth:"7 Mar 07"}
coach7 = User.new(coach7_info)
coach7.save!

coach8_info = {name: 'coach8', email: 'coach8@email.com', password:88888888, contact_number: '88888888', date_of_birth:"8 Apr 08"}
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
    date_of_birth: Faker::Date.between(from: '1980-09-23', to: '2014-09-25')
  )
  user.save!
  users << user
end

puts 'seeded 30 random users'

# Seeding sports

sport1 = Sport.new(name: 'soccer', picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1638963078/sportmelite/photo-1551958219-acbc608c6377_mbgh4g.jpg')
sport1.save!

sport2 = Sport.new(name: "badminton", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1638963078/sportmelite/photo-1521537634581-0dced2fee2ef_hyq38f.jpg')
sport2.save!

sport3 = Sport.new(name: "tennis", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1638963078/sportmelite/photo-1599586120162-c282f39edd1e_ng5snz.jpg')
sport3.save!

sport4 = Sport.new(name: "basketball", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1638963078/sportmelite/photo-1546519638-68e109498ffc_ivjqnd.jpg')
sport4.save!

sport5 = Sport.new(name: "swimming", picture_url: 'https://res.cloudinary.com/dcwfy3dua/image/upload/v1638963078/sportmelite/photo-1623720723560-d85879d0db79_xq4s2a.jpg')
sport5.save!

puts 'seeded 5 sports'

# Seeding coach profiles

coach_photo_keys = ['000016_qzr371', '000003_jqa1m9', '000002_fnv14t', '000017_kvwfnm', '00014_l5xzo9','000028_whxawg', '000029_rabe8r', '000001_ed6hct', '000006_xwroyx', '000047_wt3dc9', '000037_arjqc3','000035_zthx8s', '000009_gtwc4m', '000030_a0hvh6', '000025_wp6ur1', '000027_jvwofn', '000026_tdyakl', '000031_mi1zin', '000008_qp4gq8', '000023_jr3ckr', '000050_dfulob', '000045_zze0ah', '000042_h6rbtl']

coach_profile1 = CoachProfile.new({
  coach_start_date: DateTime.new(2010,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 5,
  sport_id: 1,
  photo_key: coach_photo_keys.sample
})
# coach_profile1.photos.key = coach_photo_keys.sample
coach_profile1.save!

coach_profile2 = CoachProfile.new({
  coach_start_date: DateTime.new(2011,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 6,
  sport_id: 2,
  photo_key: coach_photo_keys.sample
})
coach_profile2.save!

coach_profile3 = CoachProfile.new({
  coach_start_date: DateTime.new(2012,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 7,
  sport_id: 3,
  photo_key: coach_photo_keys.sample
})
coach_profile3.save!

coach_profile4 = CoachProfile.new({
  coach_start_date: DateTime.new(2013,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 8,
  sport_id: 4,
  photo_key: coach_photo_keys.sample
})
coach_profile4.save!

coach_profile5 = CoachProfile.new({
  coach_start_date: DateTime.new(2010,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 9,
  sport_id: 1,
  photo_key: coach_photo_keys.sample
})
coach_profile5.save!

coach_profile6 = CoachProfile.new({
  coach_start_date: DateTime.new(2011,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 10,
  sport_id: 2,
  photo_key: coach_photo_keys.sample
})
coach_profile6.save!

coach_profile7 = CoachProfile.new({
  coach_start_date: DateTime.new(2012,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 11,
  sport_id: 3,
  photo_key: coach_photo_keys.sample
})
coach_profile7.save!

coach_profile8 = CoachProfile.new({
  coach_start_date: DateTime.new(2013,12,1,2,3),
  description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 2),
  user_id: 12,
  sport_id: 4,
  photo_key: coach_photo_keys.sample
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
    photo_key: coach_photo_keys.sample
  )
  # file = URI.open('https://res.cloudinary.com/dcwfy3dua/image/upload/v1639193524/sportmelite/coach%20profile%20pic/drive-download-20211211T033126Z-001/000003_jqa1m9.jpg')
  # coach.photos.attach(io: file, filename: 'test.png', content_type:'image/png')
  coach.save!
end

puts 'seeded 20 random coach profiles'

# Seeding lessons
require 'date'

locations = ['Bedok ActiveSG Stadium', 'Bukit Gombak ActiveSG Stadium', 'Jurong West Sports Hall', 'Serangoon stadium', 'Jalan Besar Sports Centre' ]

 # Seeding booked lessons

coach_array = (5..12).to_a + (22..42).to_a

200.times do |i|
  year = [2021, 2022].sample
  month = rand(1..12)
  day = rand(1..7)
  hour = rand(7..20)
  lesson1 = Lesson.new({
    start_date_time: DateTime.new(year,month,day,hour,0,0),
    end_date_time: DateTime.new(year,month,day,hour+1,0,0),
    location: locations.sample,
    price: rand(5..50),
    status: true,
    student_id: rand(1..42),
    coach_id: coach_array.sample,
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
    start_date_time: DateTime.new(year,month,day,hour,0,0),
    end_date_time: DateTime.new(year,month,day,hour+1,0,0),
    location: locations.sample,
    price: rand(5..50),
    status: false,
    coach_id: coach_array.sample,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  })
  lesson1.save!
end

puts 'seeded 200 random available lessons'
