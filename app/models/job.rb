class Job < ApplicationRecord
  belongs_to :curriculum
  has_many :candidates, class_name: 'CandidateJobApplication', foreign_key: 'job_id'
end
