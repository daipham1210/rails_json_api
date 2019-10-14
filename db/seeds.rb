1_000.times do
  user = User.new
  user.full_name = Faker::Name.name
  user.phone = Faker::PhoneNumber.phone_number
  user.email = Faker::Internet.email
  user.gender = Faker::Number.between(from: 0, to: 1)
  user.nic_number = Faker::IDNumber.valid
  user.address = Faker::Address.full_address
  user.company = Faker::Company.name
  user.job = Faker::Job.title
  user.date_of_birth = Faker::Date.birthday(min_age: 18, max_age: 65)
  user.marital_status = Faker::Number.between(from: 0, to: 1)
  user.education_grade = Faker::Number.between(from: 0, to: 3)
  user.save
end
  