class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :full_name, :phone, :email, :gender, :nic_number, :address, :company, :job,
             :marital_status, :date_of_birth, :zalo, :facebook, :education_grade

  # attribute :name_with_year do |object|
  #   "#{object.name} (#{object.year})"
  # end
end