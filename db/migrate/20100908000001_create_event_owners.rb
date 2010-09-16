class CreateEventOwners < ActiveRecord::Migration
  def self.up
    create_table :events_users do |t|
      t.integer :event_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :events_users
  end
end
