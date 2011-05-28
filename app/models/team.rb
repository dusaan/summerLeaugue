class Team < ActiveRecord::Base

  has_many :matches
  has_many :invitations
  belongs_to :league

  before_save :set_ascii_name
  belongs_to :user
  belongs_to :sport
 
  has_many :teams_tournaments
  has_many :tournaments, :through => :teams_tournaments 

  has_many :team_players
  has_many :users, :through => :team_players 

  validate  :xname
  validates_presence_of   :name
 
  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb=> "100x100#",
      :small  => "150x150>" }

  def logo_path
    return logo.blank? ? "default.jpg" : logo
  end

  def phone_number
    return user ? user.phone_number : ""
  end

  def user_name
    user ? user.name : ""
  end

  private

  def set_ascii_name
    self.ascii_name = name.ascii
  end

  def xname
    return if name.nil?
    xteam = Team.find_by_ascii_name name.ascii
    return if xteam.nil?
    errors.add(:name, 'already taken') if xteam.user_id != self.user_id
  end
end
