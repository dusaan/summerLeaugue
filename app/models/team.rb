class Team < ActiveRecord::Base

  has_many :matches
  belongs_to :league

  before_save :set_ascii_name
  belongs_to :user
 
  has_many :teams_tournaments
  has_many :tournaments, :through => :teams_tournaments 
 
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
end
