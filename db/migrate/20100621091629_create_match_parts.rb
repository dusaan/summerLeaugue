class CreateMatchParts < ActiveRecord::Migration
  def self.up
    create_table :match_parts do |t|
      t.integer :part_nr
      t.integer :score1
      t.integer :score2

      t.timestamps
    end
  end

  def self.down
    drop_table :match_parts
  end
end
