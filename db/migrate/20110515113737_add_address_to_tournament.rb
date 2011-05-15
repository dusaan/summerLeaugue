class AddAddressToTournament < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :court_name, :string
  end

  def self.down
    remove_column :tournaments, :court_name
  end
end
