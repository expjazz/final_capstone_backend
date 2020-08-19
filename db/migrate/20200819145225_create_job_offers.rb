class CreateJobOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :job_offers do |t|
      t.string :requirement
      t.references :user, null: false, foreign_key: true
      t.string :salary
      t.string :position

      t.timestamps
    end
  end
end
