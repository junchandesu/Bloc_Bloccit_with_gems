class AddEmailPermissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_permission, :boolean, default: true
  end
end
