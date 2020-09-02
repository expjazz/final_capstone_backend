class CreateCandidatePersonals < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_personals do |t|
      t.references :curriculum, null: false, foreign_key: true
      t.string :children
      t.string :married
      t.string :cpf
      t.string :race
      t.string :nationality

      t.timestamps
    end
  end
end
