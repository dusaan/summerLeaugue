class CreateSeasons < ActiveRecord::Migration
  def self.up
    create_table :seasons do |t|
      t.integer :id
      t.integer :name
      t.integer :id_league
      t.integer :period
      t.integer :act_period

      t.timestamps
    end
  end

  def self.down
    drop_table :seasons
  end
end
