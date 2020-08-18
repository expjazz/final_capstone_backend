class CreateCurriculums < ActiveRecord::Migration[6.0]
  def change
    create_table :curriculums do |t|
      t.references :user, null: false, foreign_key: true
      t.string :about_me

      t.timestamps
    end
  end
end
