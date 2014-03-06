class EventMember < ActiveRecord::Base

  belongs_to :event
  belongs_to :user


  class << self

    def create_if_not_exist(event_id, user_id)
      member = EventMember.find_by_event_id_and_user_id(event_id, user_id)
      return false if member
      EventMember.create(event_id: event_id, user_id: user_id)
    end

  end

end
