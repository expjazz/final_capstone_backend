class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :job_offer_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
