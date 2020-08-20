class AddStatusToJobCandidateAssociation < ActiveRecord::Migration[6.0]
  def change
    add_column :candidate_job_applications, :status, :string

  end
end
