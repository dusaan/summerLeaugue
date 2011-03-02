class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.integer :score1
      t.integer :score2
      t.integer :points1
      t.integer :points2
      t.integer :user1_id
      t.integer :user2_id
      t.integer :league_id
      t.integer :tournament_id
      t.boolean :accepted_by_1
      t.boolean :accepted_by_2
      t.boolean :accepted_by_admin
      t.boolean :accepted_by_2
      t.boolean :played
      t.boolean :free
      t.integer :sport_id
      t.timestamp :starts_at

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
