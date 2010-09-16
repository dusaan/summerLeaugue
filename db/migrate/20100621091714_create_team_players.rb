class CreateTeamPlayers < ActiveRecord::Migration
  def self.up
    create_table :team_players do |t|
      t.integer :id_team
      t.integer :id_user

      t.timestamps
    end
  end

  def self.down
    drop_table :team_players
  end
end
