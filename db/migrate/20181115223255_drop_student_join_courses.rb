class DropStudentJoinCourses < ActiveRecord::Migration[5.2]
  def change

    drop_join_table :courses, :strudents
  end
end
