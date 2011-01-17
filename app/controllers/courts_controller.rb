class CourtsController < ApplicationController
  # GET /courts
  # GET /courts.xml
  def index
    @courts = Court.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courts }
    end
  end

  # GET /courts/1
  # GET /courts/1.xml
  def show
    @court = Court.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @court }
    end
  end

  # GET /courts/new
  # GET /courts/new.xml
  def new
    @court = Court.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @court }
    end
  end

  # GET /courts/1/edit
  def edit
    @court = Court.find(params[:id])
  end

  # POST /courts
  # POST /courts.xml
  def create
    @court = Court.new(params[:court])
    @court.user_id = @current_user.id
    respond_to do |format|
      if @court.save
        flash[:notice] = 'Ihrisko bolo úspešne vytvorené.'
        format.html { redirect_to(@court) }
        format.xml  { render :xml => @court, :status => :created, :location => @court }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @court.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courts/1
  # PUT /courts/1.xml
  def update
    @court = Court.find(params[:id])

    respond_to do |format|
      if @court.update_attributes(params[:court])
        flash[:notice] = 'Ihrisko bolo úspešne zmenené.'
        format.html { redirect_to(@court) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @court.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courts/1
  # DELETE /courts/1.xml
  def destroy
    @court = Court.find(params[:id])
    @court.destroy

    respond_to do |format|
      format.html { redirect_to(courts_url) }
      format.xml  { head :ok }
    end
  end
end
