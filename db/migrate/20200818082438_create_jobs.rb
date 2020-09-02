class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.references :curriculum, null: false, foreign_key: true
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
