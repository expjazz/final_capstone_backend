class Interview < ApplicationRecord
  belongs_to :candidate
  belongs_to :company
  belongs_to :job_offer
end
