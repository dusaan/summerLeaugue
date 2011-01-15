class Tournament < ActiveRecord::Base
  belongs_to :court
  belongs_to :user
  belongs_to :sport
  has_many :teams_tournaments
  has_many :teams, :through => :teams_tournaments 
 
  def user_name
    user ? user.name : ""
  end

  def sport_name
    sport ? sport.name : ""
  end

  def court_name
    court ? court.name : ""
  end
end
