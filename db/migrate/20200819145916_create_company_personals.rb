class CreateCompanyPersonals < ActiveRecord::Migration[6.0]
  def change
    create_table :company_personals do |t|
      t.string :cnpj
      t.string :size
      t.string :aboutUs
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
