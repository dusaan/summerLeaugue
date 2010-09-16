class Newz < ActiveRecord::Base
belongs_to :sport
validates_presence_of :sport

end
