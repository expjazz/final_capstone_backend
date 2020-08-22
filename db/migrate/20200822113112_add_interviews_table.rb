class AddInterviewsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :job_offer, null: false, foreign_key: true
      t.string :status
      t.string :time
      t.timestamps
    end
  end
end
