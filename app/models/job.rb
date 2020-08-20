class Job < ApplicationRecord
  belongs_to :curriculum
  has_many :candidates_applied, class_name: 'CandidateJobApplication', foreign_key: 'job_id'
  has_many :candidates, through: :candidates_applied, source: :candidate
end
