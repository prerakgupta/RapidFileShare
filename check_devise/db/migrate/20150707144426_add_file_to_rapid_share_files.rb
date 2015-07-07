class AddFileToRapidShareFiles < ActiveRecord::Migration
  def change
    add_column :rapid_share_files, :file, :string
  end
end
