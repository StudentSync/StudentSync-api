class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.string :semester
      t.string :schedule_availability

      t.timestamps
    end
  end
end
