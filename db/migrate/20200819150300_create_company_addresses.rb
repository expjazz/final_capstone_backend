class CreateCompanyAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :company_addresses do |t|
      t.references :company, null: false, foreign_key: true
      t.string :country
      t.string :cep
      t.string :state
      t.string :city
      t.string :hood
      t.string :street
      t.string :cel

      t.timestamps
    end
  end
end
