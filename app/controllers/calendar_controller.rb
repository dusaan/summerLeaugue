class CalendarController < ApplicationController
 
  skip_before_filter :verify_authenticity_token, :only => [:create]
 
  def index
    @month = (params[:month] || Time.zone.now.month).to_i
    @year = (params[:year] || Time.zone.now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @event_strips = Event.event_strips_for_month(@shown_month)
  end

  # GET /event/1
  # GET /event/1.xml
  def show
    @event = Event.find(params[:event_id])
  end

  def new
    @event = Event.new  	
  end

  # GET /event/1/edit
  def edit
    @event = Event.find(params[:event_id])
    puts @event.inspect
  end

  # POST /event
  # POST /event.xml
  def create
    @event = Event.new(params[:event])

      if @event.save
        flash[:notice] = 'Event bol úspešne vytvorený.'
        redirect_to calendar__path       
      else
        render :action => "new" 
      end
   
  end

  # PUT /event/1
  # PUT /event/1.xml
  def update
    @event = Event.find(params[:event_id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event bol úspešne zmenený.'
      redirect_to calendar_path
    else
      flash[:error] = 'Nepodarilo sa uložiť zmeny'
      redirect_to edit_calendar_path(@event)
    end
  end
  
end
