class Candidate < ApplicationRecord
  has_one :user, as: :profile
end
