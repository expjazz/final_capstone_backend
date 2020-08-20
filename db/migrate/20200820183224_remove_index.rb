class RemoveIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :candidate_job_applicationsZ, name: "index_candidate_job_applications_on_candidate_id"
    remove_index :candidate_job_applications, name: "index_candidate_job_applications_on_job_id"


  end
end
