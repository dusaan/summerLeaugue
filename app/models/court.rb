class Court < ActiveRecord::Base
  belongs_to :user
  has_many :tournament
  
end
