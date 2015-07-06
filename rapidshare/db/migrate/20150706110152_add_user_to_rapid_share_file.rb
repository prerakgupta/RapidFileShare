class AddUserToRapidShareFile < ActiveRecord::Migration
  def change
    add_reference :rapid_share_files, :user, index: true, foreign_key: true
  end
end
