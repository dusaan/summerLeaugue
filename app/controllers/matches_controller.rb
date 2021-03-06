class MatchesController < ApplicationController
	  # GET /matches
	  # GET /matches.xml

  	
  def index
    @matches = Match.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
    end
  end

  def join
    @match = Match.find(params[:match_id])
    Match.transaction do
      return unless @match.user2.blank?
      @match.user2 = @current_user 
      @match.save
      Event.create! :user_id =>@current_user.id, :match_id => @match.id, :start_at => @match.starts_at
      Event.create! :user_id =>@match.user1.id, :match_id => @match.id, :start_at => @match.starts_at
    end
    redirect_to(@match) 
  end

  # GET /matches/1
  # GET /matches/1.xml
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.xml
  def new
    @match = Match.new :user1 => @current_user, :free => true

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.xml
  def create
    starts_at = Time.parse("#{params[:starts_at]} #{params[:match][:time][:hour]}:#{params[:match][:time][:minute]}")
    @match = Match.new :free => true, :starts_at => starts_at, :user1=> @current_user, :sport_id => @selected_sport
    respond_to do |format|
      if @match.save
        flash[:notice] = 'Zápas bol úspešne vytvorený.'
        format.html { redirect_to(@match) }
        format.xml  { render :xml => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.xml
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        flash[:notice] = 'Zápas bol úspešne zmenený.'
        format.html { redirect_to(@match) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.xml
  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to(matches_url) }
      format.xml  { head :ok }
    end
  end
  
  def edit_match_score
    @match = Match.find(params[:id])
  end
  
  def update_score
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        flash[:notice] = 'Score zápasu bol úspešne zmenený.'
        format.html { redirect_to(tournament_matches_path(@match.tournament_id)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "update_score" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end
end
