class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.integer :score1
      t.integer :score2
      t.integer :points1
      t.integer :points2

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
