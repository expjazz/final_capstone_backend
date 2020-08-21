class JobOffer < ApplicationRecord
  belongs_to :user
  has_many :candidates_applied, class_name: 'CandidateJobApplication', foreign_key: 'job_offer_id'
  has_many :candidates, through: :candidates_applied, source: :candidate

  has_many :applications_accepted, class_name: 'ApplicationAccepted', foreign_key: 'job_offer_id'
  has_many :approved, through: :applications_accepted, source: :candidate
end
