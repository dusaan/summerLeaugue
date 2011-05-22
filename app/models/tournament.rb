class Tournament < ActiveRecord::Base
  belongs_to :court
  belongs_to :user
  belongs_to :sport
  has_many :teams_tournaments
  has_many :teams, :through => :teams_tournaments 
  has_many :matches

  named_scope :with_image, lambda { { :conditions => ['pic_path IS NOT  ?', nil] } }

  def user_name
    user ? user.name : ""
  end

  def sport_name
    sport ? sport.name : ""
  end

  def courtname
    self.court_name ? self.court_name : (court ? court.name : "")
  end

  def generate_matches
    self.matches = []
    self.save
    tmp_teams = self.teams.combination(2).to_a
    tmp_teams.collect do |team|
      st_at = st_at ? (st_at + 15.minutes) : self.starts_at
      Match.create! :tournament_id => self.id, :team1_id => team.first.id, :team2_id => team.last.id, :sport_id => self.sport_id, :starts_at => st_at
    end
  end
end
