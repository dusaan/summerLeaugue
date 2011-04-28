# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110428113737) do

  create_table "courts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "surface"
    t.string   "description"
    t.integer  "courts"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_users", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_players", :force => true do |t|
    t.integer  "league_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "rounds"
    t.datetime "starts_at"
    t.datetime "finishes_at"
    t.integer  "rounds_played"
    t.integer  "sport_id"
    t.integer  "teams_count"
    t.integer  "users_count"
    t.integer  "league_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_parts", :force => true do |t|
    t.integer  "part_nr"
    t.integer  "score1"
    t.integer  "score2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "score1"
    t.integer  "score2"
    t.integer  "points1"
    t.integer  "points2"
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "league_id"
    t.integer  "tournament_id"
    t.boolean  "accepted_by_1"
    t.boolean  "accepted_by_2"
    t.boolean  "accepted_by_admin"
    t.boolean  "played"
    t.boolean  "free"
    t.integer  "sport_id"
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "subject",     :limit => 256
    t.text     "body"
    t.datetime "sent_at",                    :null => false
    t.datetime "read_at"
  end

  create_table "newzs", :force => true do |t|
    t.integer  "sport_id"
    t.text     "text"
    t.string   "header"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", :force => true do |t|
    t.datetime "starts_at"
    t.datetime "finishes_at"
    t.boolean  "finished"
    t.integer  "league_id"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sport_players", :force => true do |t|
    t.integer  "sport_id"
    t.integer  "user_id"
    t.integer  "ranking"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.integer  "parts"
    t.boolean  "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_players", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.integer  "max_players"
    t.integer  "league_id"
    t.integer  "sport_id"
    t.string   "ascii_name"
    t.integer  "user_id"
    t.integer  "total_score"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams_tournaments", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "team_id"
    t.boolean  "confirmed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", :force => true do |t|
    t.integer  "court_id"
    t.string   "name"
    t.integer  "sport_id"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "starts_at"
    t.boolean  "male"
    t.boolean  "female"
    t.boolean  "mix"
    t.boolean  "played"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "salt"
    t.string   "digest"
    t.string   "email"
    t.string   "phone_number"
    t.string   "user_role"
    t.datetime "reg_date"
    t.string   "gender"
    t.string   "foto"
    t.integer  "league_level"
    t.integer  "ranking"
    t.string   "register_link"
    t.string   "ascii_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "interested_in"
  end

end
