class ChangeTournament < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE tournaments ALTER description TYPE text;"
  end
  def self.down
    drop_table :tournaments
  end
end
