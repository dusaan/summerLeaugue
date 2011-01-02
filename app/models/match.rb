class Match < ActiveRecord::Base

belongs_to :team1, :class_name => 'Team'
belongs_to :team2, :class_name => 'Team'
belongs_to :user1, :class_name => 'User'
belongs_to :user2, :class_name => 'User'
belongs_to :event
belongs_to :league
end

