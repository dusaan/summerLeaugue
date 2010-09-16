class CalendarController < ApplicationController
  
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

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /event/1
  # PUT /event/1.xml
  def update
    @event = Event.find(params[:event_id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to calendar_path
    else
      flash[:error] = 'Prdlo to, ty HAD!.'
      redirect_to edit_calendar_path(@event)
    end
  end
  
end
