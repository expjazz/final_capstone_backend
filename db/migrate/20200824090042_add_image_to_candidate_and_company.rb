class AddImageToCandidateAndCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :image_url, :string
    add_column :companies, :image_url, :string

  end
end
