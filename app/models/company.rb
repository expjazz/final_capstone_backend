class Company < ApplicationRecord
  has_one :user, as: :profile
  has_one :company_personal
  has_one :company_address
  has_many :interviews
end
