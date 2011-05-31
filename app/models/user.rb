class User < ActiveRecord::Base
  include Security
  include ApplicationHelper

  has_and_belongs_to_many :events
  has_many :sport_players
  has_many :sports, :through => :sport_players 

  has_many :courts
  has_many :tournaments

  has_many :league_players
  has_many :leagues, :through => :league_players 

  has_many :team_players
  has_many :teams, :through => :team_players 

  has_many :invitations
  
  before_save :set_ascii_name

  attr_accessor   :password, :password_confirmation
  validates_presence_of     :email
  validates_uniqueness_of :vs
  
#  validates_presence_of     :first_name
#  validates_presence_of     :last_name
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => false
  validates_uniqueness_of   :email, :if => :email_changed?

  validates_presence_of     :password,              :if => :password_needed?
  validates_presence_of     :password_confirmation, :if => :password_needed?
  before_create :generate_link
  before_create :set_vs
  before_update :encrypt_password, :if => :password_needed?

  def set_ascii_name
    self.ascii_name = name.ascii
  end

  def set_vs
    self.vs = randomInt(10)
  end
  
  def generate_link
    self.register_link =  randomStr(20)
    mail = nil
    if teams.blank?
      mail = Notifier.create_feedback(self)
    else
      mail = Notifier.create_invitation(self)
    end
    Notifier.deliver(mail)
    encrypt_password
  end

  def admin?
    self.user_role == "admin"  
  end
  def name
    return email unless first_name || last_name 
    "#{first_name ? first_name.strip.capitalize : ""} #{last_name ? last_name.strip.capitalize : "" }"
  end

  def invite_existing_to(team)
    self.teams = [team]
    self.sports = [team.sport]
  end
  
  def invite_to(team)
    self.teams = [team]
    self.sports = [team.sport]
    self.password_confirmation = self.password = randomStr(20)
  end

  def password_needed?
    (password && !password.empty?) || (password_confirmation && !password_confirmation.empty?) || (salt.blank? || digest.blank?)
  end

  def self.authenticate(login, password)
    user = User.find_by_email(login.downcase)
    user && user.register_link.nil? && user.authenticated?(password.downcase) ? user : nil
  end

  def authenticated?(password)
    password && salt && digest && digest == encrypt(salt, password)
  end

  def email=(email)
    write_attribute(:email, email ? email.downcase : nil)
  end

  def foto_path
    return foto.blank? ? (self.gender=="Muž" ? "default_male.png" : "default_female.png") : foto
  end
 def messages
    Message.find :all, :conditions => ["messages.sender_id = ? or messages.receiver_id = ?", id, id], :order => "messages.sent_at desc"
  end
  def unread_messages
    Message.find :all, :conditions => ["messages.receiver_id = ? AND read_at is null", id], :order =>     "messages.sent_at desc"
  end
  
  def can_join? (sport_name)
    return false unless (self.sports.find_by_name sport_name).nil?
    true
    #(self.interested_in == sport_name || self.interested_in == "all")
  end

  def encrypt_password

    self.salt = encrypt(Time.now.to_s, String.random(40))
    self.digest = encrypt(salt, (password).downcase)
    self.password = nil
    self.password_confirmation = nil
  end
end
