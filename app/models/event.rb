class Event < ActiveRecord::Base
  has_event_calendar
  has_and_belongs_to_many :users
end
