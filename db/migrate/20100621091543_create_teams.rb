class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.string :logo
      t.integer :max_players
      t.integer :league_id
      t.integer :sport_id
	    t.string  :ascii_name, :unique => true 
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
