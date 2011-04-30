class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.string :logo
      t.integer :league_id
      t.integer :sport_id
	    t.string  :ascii_name, :unique => true 
      t.integer :user_id
      t.integer :total_score
      t.string  :photo_file_name # Original filename
      t.string  :photo_content_type # Mime type
      t.integer :photo_file_size # File size in bytes
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
