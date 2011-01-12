class User < ActiveRecord::Base
  include Security
  has_and_belongs_to_many :events
  has_many :sport_players
  has_many :sports, :through => :sport_players 
  has_many :courts
  has_many :tournaments
  has_many :league_players
  has_many :leagues, :through => :league_players 


  attr_accessor   :password, :password_confirmation
  validates_presence_of     :email
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => false
  validates_uniqueness_of   :email, :if => :email_changed?
  validates_presence_of     :password,              :if => :password_needed?
  validates_presence_of     :password_confirmation, :if => :password_needed?
  after_validation :encrypt_password, :if => :password_needed?

  def name
    "#{first_name} #{last_name}".strip.capitalize
  end

  def password_needed?
    (password && !password.empty?) || (password_confirmation && !password_confirmation.empty?) || (salt.blank? || digest.blank?)
  end

  def self.authenticate(login, password)
    user = User.find_by_email(login.downcase)
    user && user.authenticated?(password.downcase) ? user : nil
  end

  def authenticated?(password)
    password && salt && digest && digest == encrypt(salt, password)
  end

  def email=(email)
    write_attribute(:email, email ? email.downcase : nil)
  end

  def foto_path
    return foto.blank? ? "default.jpg" : foto
  end
 def messages
    Message.find :all, :conditions => ["messages.sender_id = ? or messages.receiver_id = ?", id, id], :order => "messages.sent_at desc"
  end
  def encrypt_password

    self.salt = encrypt(Time.now.to_s, String.random(40))
    self.digest = encrypt(salt, password.downcase)
    self.password = nil
    self.password_confirmation = nil
  end
end
