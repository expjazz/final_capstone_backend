class DropCandidateJobs < ActiveRecord::Migration[6.0]
  def change
    drop_table :candidate_job_applications

  end
end
