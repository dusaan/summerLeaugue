class CreateSportPlayers < ActiveRecord::Migration
  def self.up
    create_table :sport_players do |t|
      t.integer :sport_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sport_players
  end
end
