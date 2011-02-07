class CreateTournamentTeams < ActiveRecord::Migration
  def self.up
    create_table :teams_tournaments do |t|
      t.integer :tournament_id
      t.integer :team_id
      t.boolean :confirmed, :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :teams_tournaments
  end
end
