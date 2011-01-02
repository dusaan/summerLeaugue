class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.integer :user_id
      t.integer :match_id
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
