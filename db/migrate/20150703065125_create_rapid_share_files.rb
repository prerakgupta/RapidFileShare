class CreateRapidShareFiles < ActiveRecord::Migration
  def change
    create_table :rapid_share_files do |t|
      t.binary :file, :limit => 2.megabyte
      t.string :title

      t.timestamps null: false
    end
  end
end
