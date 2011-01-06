class CreateCourts < ActiveRecord::Migration
  def self.up
    create_table :courts do |t|
      t.integer :user_id
      t.string :name
      t.string :street
      t.string :city
      t.string :surface
      t.string :description
      t.integer :courts
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :courts
  end
end
