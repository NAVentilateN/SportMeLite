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

5.times do |i|
  year = [2022, 2023, 2024].sample
  lesson1 = Lesson.new({
    start_date_time: DateTime.new(year,12,1,2,3),
    end_date_time: DateTime.new(year,12,1,3,3),
    location: 'somewhere',
    price: 10,
    status: true,
    student_id: 1,
    coach_id: 5,
    description: 'Swimming for Beginners'
  })
  lesson1.save!
end

5.times do |i|
  year = [2022, 2023, 2024].sample
  lesson2 = Lesson.new({
    start_date_time: DateTime.new(year,12,2,2,3),
    end_date_time: DateTime.new(year,12,2,3,3),
    location: 'anywhere',
    price: 10,
    status: true,
    student_id: 2,
    coach_id: 6,
    description: 'Advanced Badminton'
  })
  lesson2.save!
end

5.times do
  year = [2022, 2023, 2024].sample
  lesson3 = Lesson.new({
    start_date_time: DateTime.new(year,12,3,2,3),
    end_date_time: DateTime.new(year,12,3,3,3),
    location: 'nowhere',
    price: 10,
    status: false,
    coach_id: 7,
    description: 'Calisthenics 1'
  })
  lesson3.save!
end

5.times do
  year = [2022, 2023, 2024].sample
  lesson4 = Lesson.new({
    start_date_time: DateTime.new(year,12,4,2,3),
    end_date_time: DateTime.new(year,12,4,3,3),
    location: 'where',
    price: 10,
    status: false,
    coach_id: 8,
    description: 'Krav Maga'
  })
  lesson4.save!
end

5.times do
  year = [2022, 2023, 2024].sample
  lesson5 = Lesson.new({
    start_date_time: DateTime.new(year,12,7,5,3),
    end_date_time: DateTime.new(year,12,7,6,3),
    location: 'YCK swimming pool',
    price: 100,
    status: false,
    coach_id: 9,
    description: 'Swimming for Intermediate'
  })
  lesson5.save!
end

5.times do
  year = [2022, 2023, 2024].sample
  lesson6 = Lesson.new({
    start_date_time: DateTime.new(year,12,2,2,3),
    end_date_time: DateTime.new(year,12,2,3,3),
    location: 'anywhere',
    price: 10,
    status: false,
    coach_id: 10,
    description: 'Advanced Badminton'
  })
  lesson6.save!
end

5.times do
  year = [2022, 2023, 2024].sample
  lesson7 = Lesson.new({
    start_date_time: DateTime.new(year,12,3,2,3),
    end_date_time: DateTime.new(year,12,3,3,3),
    location: 'nowhere',
    price: 10,
    status: false,
    coach_id: 11,
    description: 'Calisthenics 1'
  })
  lesson7.save!
end

5.times do
  year = [2022, 2023, 2024].sample
  lesson8 = Lesson.new({
    start_date_time: DateTime.new(year,12,4,2,3),
    end_date_time: DateTime.new(year,12,4,3,3),
    location: 'where',
    price: 10,
    status: false,
    coach_id: 12,
    description: 'Krav Maga'
  })
  lesson8.save!
end

puts 'seeded 40 lessons'


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

coach_profile5 = CoachProfile.new({
  coach_start_date: DateTime.new(2010,12,1,2,3),
  description: 'Good coach 1',
  user_id: 9,
  sport_id: 1
})
coach_profile5.save!

coach_profile6 = CoachProfile.new({
  coach_start_date: DateTime.new(2011,12,1,2,3),
  description: 'Good coach 2',
  user_id: 10,
  sport_id: 2
})
coach_profile6.save!

coach_profile7 = CoachProfile.new({
  coach_start_date: DateTime.new(2012,12,1,2,3),
  description: 'Good coach 3',
  user_id: 11,
  sport_id: 3
})
coach_profile7.save!

coach_profile8 = CoachProfile.new({
  coach_start_date: DateTime.new(2013,12,1,2,3),
  description: 'Good coach 4',
  user_id: 12,
  sport_id: 4
})
coach_profile8.save!

puts 'seeded 8 coach profiles'
