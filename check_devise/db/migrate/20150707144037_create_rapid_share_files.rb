class CreateRapidShareFiles < ActiveRecord::Migration
  def change
    create_table :rapid_share_files do |t|

      t.timestamps null: false
    end
  end
end
