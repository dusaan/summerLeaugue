class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :salt
      t.string :digest
      t.string :email
      t.string :phone_number
      t.string :user_role
      t.timestamp :reg_date
      t.string :gender
      t.string :foto
      t.integer :league_level
      t.integer :ranking
      t.string :register_link
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
