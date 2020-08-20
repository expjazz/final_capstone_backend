class Candidate < ApplicationRecord
  has_one :user, as: :profile
  has_many :jobs_applied, class_name: 'CandidateJobApplication', foreign_key: 'candidate_id'
  has_many :jobs_tried, through: :jobs_applied, source: :job_offer
end
