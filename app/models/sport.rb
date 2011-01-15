class Sport < ActiveRecord::Base
  has_many :newzs
  has_many :leagues
  has_many :tournaments

  has_many :sport_players
  has_many :users, :through => :sport_players 
#delegate :sport_name => :name, :to => :leagues
 
end
