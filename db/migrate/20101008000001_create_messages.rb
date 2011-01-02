class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table "messages", :force => true do |t|
      t.integer  "sender_id"
      t.integer  "receiver_id"
      t.string   "subject",     :limit => 256
      t.text     "body"
      t.datetime "sent_at",                                   :null => false
      t.datetime "read_at"
    end
  end

  def self.down
    drop_table :messages
  end
end
