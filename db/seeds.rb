# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

puts 'seeded 4 students and 4 coaches'


sport1 = Sport.new(name: 'soccer')
sport1.save!

sport2 = Sport.new(name: "badminton")
sport2.save!

sport3 = Sport.new(name: "tennis")
sport3.save!

sport4 = Sport.new(name: "basketball")
sport4.save!

sport5 = Sport.new(name: "swimming")
sport5.save!

puts 'seeded 5 sports'

#seeding lessons
require 'date'

lesson1 = Lesson.new({
  start_date_time: DateTime.new(2022,12,1,2,3),
  end_date_time: DateTime.new(2022,12,1,3,3),
  location: 'somewhere',
  price: 10,
  status: true,
  student_id: 1,
  coach_id: 5,
  description: 'Swimming for Beginners'
})
lesson1.save!

lesson2 = Lesson.new({
  start_date_time: DateTime.new(2022,12,2,2,3),
  end_date_time: DateTime.new(2022,12,2,3,3),
  location: 'anywhere',
  price: 10,
  status: true,
  student_id: 2,
  coach_id: 6,
  description: 'Advanced Badminton'
})
lesson2.save!

lesson3 = Lesson.new({
  start_date_time: DateTime.new(2022,12,3,2,3),
  end_date_time: DateTime.new(2022,12,3,3,3),
  location: 'nowhere',
  price: 10,
  status: true,
  student_id: 3,
  coach_id: 7,
  description: 'Calisthenics 1'
})
lesson3.save!

lesson4 = Lesson.new({
  start_date_time: DateTime.new(2022,12,4,2,3),
  end_date_time: DateTime.new(2022,12,4,3,3),
  location: 'where',
  price: 10,
  status: false,
  coach_id: 8,
  description: 'Krav Maga'
})
lesson4.save!

puts 'seeded 4 lessons'

coach_profile1 = CoachProfile.new({
  coach_start_date: DateTime.new(2010,12,1,2,3),
  description: 'Good coach 1',
  user_id: 5,
  sport_id: 1
})
coach_profile1.save!

coach_profile2 = CoachProfile.new({
  coach_start_date: DateTime.new(2011,12,1,2,3),
  description: 'Good coach 2',
  user_id: 6,
  sport_id: 2
})
coach_profile2.save!

coach_profile3 = CoachProfile.new({
  coach_start_date: DateTime.new(2012,12,1,2,3),
  description: 'Good coach 3',
  user_id: 7,
  sport_id: 3
})
coach_profile3.save!

coach_profile4 = CoachProfile.new({
  coach_start_date: DateTime.new(2013,12,1,2,3),
  description: 'Good coach 4',
  user_id: 8,
  sport_id: 4
})
coach_profile4.save!

puts 'seeded 4 coach profiles'
