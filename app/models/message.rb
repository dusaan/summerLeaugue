class Message < ActiveRecord::Base

  belongs_to :sender,   :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  validates_presence_of :sender, :receiver

  before_create :set_sent_at

  delegate :sender_name => :name,   :to => :sender
  delegate :receiver_name => :name, :to => :receiver

  def sender_name
    sender ? sender.name : ""
  end
  
  def receiver_name
    receiver ? receiver.name : ""
  end
  private

  def set_sent_at
    self.sent_at ||= Time.now.utc
  end
end
