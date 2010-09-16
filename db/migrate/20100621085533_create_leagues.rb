class CreateLeagues < ActiveRecord::Migration
  def self.up
    create_table :leagues do |t|
      t.string :name
      t.integer :rounds
      t.timestamp :starts_at
      t.timestamp :finishes_at
      t.integer :rounds_played
      t.integer :sport_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leagues
  end
end
