class Candidate < ApplicationRecord
  has_one :user, as: :profile
  has_many :job_applications, class_name: 'CandidateJobApplication', foreign_key: 'candidate_id'

end
