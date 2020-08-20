class JobOffer < ApplicationRecord
  belongs_to :user
  has_many :candidates_applied, class_name: 'CandidateJobApplication', foreign_key: 'job_offer_id'
  has_many :candidates, through: :candidates_applied, source: :candidate
end
