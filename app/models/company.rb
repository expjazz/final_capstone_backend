class Company < ApplicationRecord
  has_one :user, as: :profile
end
