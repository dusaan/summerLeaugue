class AddPicPathToTournament < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :pic_path, :string
  end

  def self.down
    remove_column :tournaments, :pic_path
  end
end
