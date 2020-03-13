class Teacher < ActiveRecord::Base
  has_many :students
  has_many :parties, through: :students

  has_secure_password
end
