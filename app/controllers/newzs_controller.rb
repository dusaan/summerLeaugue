class NewzsController < ApplicationController
  # GET /newzs
  # GET /newzs.xml
 skip_before_filter :authenticate
  def index
   
    @newzs = params[:sport].blank? ? (Newz.find :all) : (Newz.find_all_by_sport_id params[:sport])
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @newzs }
    end
  end

  def rules
    @sport_type = params[:sport]
  end

  def default
  end

  # GET /newzs/1
  # GET /newzs/1.xml
  def show
    @newz = Newz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @newz }
    end
  end

  # GET /newzs/new
  # GET /newzs/new.xml
  def new
    @newz = Newz.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @newz }
    end
  end

  # GET /newzs/1/edit
  def edit
    @newz = Newz.find(params[:id])
  end

  # POST /newzs
  # POST /newzs.xml
  def create
    @newz = Newz.new(params[:newz])

    respond_to do |format|
      if @newz.save
        flash[:notice] = 'Novinka bola úspešne vytvorená.'
        format.html { redirect_to(@newz) }
        format.xml  { render :xml => @newz, :status => :created, :location => @newz }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @newz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /newzs/1
  # PUT /newzs/1.xml
  def update
    @newz = Newz.find(params[:id])

    respond_to do |format|
      if @newz.update_attributes(params[:newz])
        flash[:notice] = 'Novinka bola úspešne zmenená.'
        format.html { redirect_to(@newz) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @newz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /newzs/1
  # DELETE /newzs/1.xml
  def destroy
    @newz = Newz.find(params[:id])
    @newz.destroy

    respond_to do |format|
      format.html { redirect_to(newzs_url) }
      format.xml  { head :ok }
    end
  end
end
