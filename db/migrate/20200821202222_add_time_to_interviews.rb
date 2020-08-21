class AddTimeToInterviews < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :time, :string
  end
end
