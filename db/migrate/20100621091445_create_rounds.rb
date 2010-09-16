class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.timestamp :starts_at
      t.timestamp :finishes_at
      t.boolean :finished
      t.integer :league_id
      t.integer :sport_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
