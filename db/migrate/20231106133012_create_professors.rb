class CreateProfessors < ActiveRecord::Migration[7.1]
  def change
    create_table :professors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :academic_degree
      t.text :description

      t.timestamps
    end
  end
end
