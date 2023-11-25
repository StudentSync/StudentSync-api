class AddScheduleAvailabilityToProfessors < ActiveRecord::Migration[7.1]
  def change
    add_column :professors, :schedule_availability, :string
  end
end
