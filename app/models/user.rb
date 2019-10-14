class User < ApplicationRecord
  enum gender: {
    female: 0,
    male: 1
  }

  enum marital_status: {
    single: 0,
    married: 1,
    divorced: 2,
    widowed: 3
  }

  enum education_grade: {
    second_high_school: 0,
    high_school: 1,
    collage: 2,
    university: 3
  }
end
