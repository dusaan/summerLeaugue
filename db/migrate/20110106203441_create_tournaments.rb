class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.integer :court_id
      t.string :name
      t.integer :sport_id
      t.string :description
      t.integer :user_id
      t.timestamp :starts_at
      t.boolean :male
      t.boolean :female
      t.boolean :mix
      t.boolean :played
      t.timestamps
    end
  end

  def self.down
    drop_table :tournaments
  end
end
