class Candidate < ApplicationRecord
  has_one :user, as: :profile
  has_many :jobs_applied, class_name: 'CandidateJobApplication', foreign_key: 'candidate_id'
  has_many :jobs_tried, through: :jobs_applied, source: :job_offer

  has_many :applications_accepted, class_name: 'ApplicationAccepted', foreign_key: 'candidate_id'
  has_many :jobs_accepted, through: :applications_accepted, source: :job_offer
  has_many :interviews
end
