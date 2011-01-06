class Match < ActiveRecord::Base

  belongs_to :team1, :class_name => 'Team'
  belongs_to :team2, :class_name => 'Team'
  belongs_to :user1, :class_name => 'User'
  belongs_to :user2, :class_name => 'User'
  belongs_to :event
  belongs_to :league
  after_save :update_events
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

  def update_events
    Event.destroy_all :match_id => self.id if self.id
    Event.create! :name => "Zapas: #{user1_name} vs. #{user2_name}", :start_at => starts_at, :end_at => (starts_at ? starts_at + 2.hours : nil), :user_id => user1.id, :match_id => self.id if user1
    Event.create! :name => "Zapas: #{user1_name} vs. #{user2_name}", :start_at => starts_at, :end_at => (starts_at ? starts_at + 2.hours : nil), :user_id => user2.id, :match_id => self.id if user2

  end
end

