class Removebugfrominterviews < ActiveRecord::Migration[6.0]
  def change
    drop_table :interviews
  end
end
