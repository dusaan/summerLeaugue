class MatchPartsController < ApplicationController
  # GET /match_parts
  # GET /match_parts.xml
  def index
    @match_parts = MatchPart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @match_parts }
    end
  end

  # GET /match_parts/1
  # GET /match_parts/1.xml
  def show
    @match_part = MatchPart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match_part }
    end
  end

  # GET /match_parts/new
  # GET /match_parts/new.xml
  def new
    @match_part = MatchPart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match_part }
    end
  end

  # GET /match_parts/1/edit
  def edit
    @match_part = MatchPart.find(params[:id])
  end

  # POST /match_parts
  # POST /match_parts.xml
  def create
    @match_part = MatchPart.new(params[:match_part])

    respond_to do |format|
      if @match_part.save
        flash[:notice] = 'MatchPart was successfully created.'
        format.html { redirect_to(@match_part) }
        format.xml  { render :xml => @match_part, :status => :created, :location => @match_part }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match_part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /match_parts/1
  # PUT /match_parts/1.xml
  def update
    @match_part = MatchPart.find(params[:id])

    respond_to do |format|
      if @match_part.update_attributes(params[:match_part])
        flash[:notice] = 'MatchPart was successfully updated.'
        format.html { redirect_to(@match_part) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match_part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /match_parts/1
  # DELETE /match_parts/1.xml
  def destroy
    @match_part = MatchPart.find(params[:id])
    @match_part.destroy

    respond_to do |format|
      format.html { redirect_to(match_parts_url) }
      format.xml  { head :ok }
    end
  end
end
