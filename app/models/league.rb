class League < ActiveRecord::Base
  has_many :teams
  belongs_to :sport
  before_save :set_users_count
  
  has_many :league_players
  has_many :users, :through => :league_players 
  has_many :matches

  def sport_name
    sport ? sport.name : ""
  end
  def set_users_count
    self.users_count = self.users.count
  end

  def matches_count
    return 840 if self.users.count == 7
    return 120 if self.users.count == 6
    return 24 if self.users.count == 5
    return 6 if self.users.count == 4
    return 0
    
  end
end
