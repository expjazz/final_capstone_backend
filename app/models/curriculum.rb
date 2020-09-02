class Curriculum < ApplicationRecord
  belongs_to :user
  has_many :jobs
  has_one :candidate_address
  has_one :candidate_personal
end
