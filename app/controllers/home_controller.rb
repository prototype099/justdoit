class HomeController < ApplicationController
  def index

    now = Time.now 
    logger.debug "Now is #{now}"
    #@events = Event.all 
    @events = Event.includes(event_members: { user: :oauth_tokens })
                    .where("start_time <= ?", now)
                    .where("? < end_time", now)
                    .order(:end_time).reverse_order

  end
end
