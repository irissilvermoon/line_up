class RemoveInvitationTokenLimitFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :invitation_token, :string, :limit => 60
  	add_column :users, :invitation_token, :string
  end
end
