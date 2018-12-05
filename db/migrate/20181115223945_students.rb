class Students < ActiveRecord::Migration[5.2]
  def change
    drop_table :students
  end
end
