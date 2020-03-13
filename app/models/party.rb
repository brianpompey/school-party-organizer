class Party < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher, through: :student
end
