class CreateNewzs < ActiveRecord::Migration
  def self.up
    create_table :newzs do |t|
      t.integer :sport_id
      t.text :text
      t.string :header

      t.timestamps
    end
  end

  def self.down
    drop_table :newzs
  end
end
