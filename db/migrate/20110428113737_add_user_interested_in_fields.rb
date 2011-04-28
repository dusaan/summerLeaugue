class AddUserInterestedInFields < ActiveRecord::Migration
  def self.up
    add_column :users, :interested_in, :string
  end

  def self.down
    remove_column :users, :interested_in
  end
end
