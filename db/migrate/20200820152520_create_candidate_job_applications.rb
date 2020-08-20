class CreateCandidateJobApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_job_applications do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
    add_index :candidate_job_applications, %i[candidate job], unique: true
  end
end
