class CreateSports < ActiveRecord::Migration
  def self.up
    create_table :sports do |t|
      t.integer :id
      t.string  :name
      t.integer :parts
      t.boolean :team
      t.integer :max_players
      t.timestamps
    end
  end

  def self.down
    drop_table :sports
  end
end
