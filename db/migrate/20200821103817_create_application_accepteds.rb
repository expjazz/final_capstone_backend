class CreateApplicationAccepteds < ActiveRecord::Migration[6.0]
  def change
    create_table :application_accepteds do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :job_offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
