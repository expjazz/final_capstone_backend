class FixBugs < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_job_applications do |t|

      t.references :candidate, null: false, foreign_key: true
      t.references :job_offer, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
