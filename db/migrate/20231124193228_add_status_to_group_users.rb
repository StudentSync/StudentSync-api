class AddStatusToGroupUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :group_users, :status, :string, default: 'pending'
  end
end
