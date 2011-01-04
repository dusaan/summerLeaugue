class Match < ActiveRecord::Base

  belongs_to :team1, :class_name => 'Team'
  belongs_to :team2, :class_name => 'Team'
  belongs_to :user1, :class_name => 'User'
  belongs_to :user2, :class_name => 'User'
  belongs_to :event
  belongs_to :league
 
  def user1_name
    user1 ? user1.name.capitalize : ""
  end  

  def user2_name
    user2 ? user2.name.capitalize : ""
  end  

  def team1_name
    team1 ? team1.name.capitalize : ""
  end  

  def team2_name
    team2 ? team2.name.capitalize : ""
  end  

end

