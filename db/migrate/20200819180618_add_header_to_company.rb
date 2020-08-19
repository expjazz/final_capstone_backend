class AddHeaderToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :header, :string
  end
end
