class TeamsTournament < ActiveRecord::Base
  belongs_to :team
  belongs_to :tournament

  before_create :generate_invitation

  def generate_invitation
    Message.create! :sender_id => tournament.user_id, :receiver_id => team.user_id, :subject => "Pozvánka",  :body => "Používateľ #{tournament.user.name} Ťa pozval na turnaj #{tournament.name}.\n V nastaveniach tímu môžeš potvrdiť účasť."
  end  

end
