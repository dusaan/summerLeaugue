class Tournament < ActiveRecord::Base
  belongs_to :court
  belongs_to :user

  def user_name
    user ? user.name : ""
  end
  def court_name
    court ? court.name : ""
  end
end
