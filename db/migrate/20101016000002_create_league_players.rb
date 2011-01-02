class CreateLeaguePlayers < ActiveRecord::Migration
  def self.up
    create_table :league_players do |t|
      t.integer :league_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :league_players
  end
end
