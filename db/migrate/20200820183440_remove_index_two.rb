class RemoveIndexTwo < ActiveRecord::Migration[6.0]
  def change
    remove_index :candidate_job_applications, name: "index_candidate_job_applications_on_candidate_and_job"

  end
end
