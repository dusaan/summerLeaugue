class LeaguesController < ApplicationController
  # GET /leagues
  # GET /leagues.xml
  def index
    @leagues = League.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end
  def edit_league_teams
    @league = League.find(params[:league_id])
    @league_teams = @league.teams.find :all
    @other_teams = Team.find :all, :conditions => ["sport_id = ? AND league_id IS NULL", @league.sport_id]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end
  # GET /leagues/1
  # GET /leagues/1.xml
  def show
    @league = League.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.xml
  def new
    @league = League.new :rounds_played => 0

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.xml
  def create
    starts_at = Time.parse(params[:starts_at])
    finishes_at = Time.parse(params[:finishes_at])
    @league = League.new(params[:league].merge(:rounds_played => 0, :starts_at => starts_at, :finishes_at => finishes_at))

    respond_to do |format|
      if @league.save
        flash[:notice] = 'League was successfully created.'
        format.html { redirect_to(@league) }
        format.xml  { render :xml => @league, :status => :created, :location => @league }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.xml
  def update
    @league = League.find(params[:id])
    starts_at = Time.parse(params[:starts_at])
    finishes_at = Time.parse(params[:finishes_at])
    respond_to do |format|
      if @league.update_attributes(params[:league].merge(:starts_at => starts_at, :finishes_at => finishes_at))
        flash[:notice] = 'League was successfully updated.'
        format.html { redirect_to(@league) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end
  def league_team_add
    team = Team.find(params[:team_id])
    league = League.find(params[:league_id])
    team.league = league
    team.save
    redirect_to edit_league_teams_path(league)
  end

  def remove_league_team
    team = Team.find(params[:team_id])
    league = team.league
    team.league = nil
    team.save
    redirect_to edit_league_teams_path(league)
  end
  # DELETE /leagues/1
  # DELETE /leagues/1.xml
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to(leagues_url) }
      format.xml  { head :ok }
    end
  end

  def to_time(input)
    "#{input.year}-#{input.month}-#{input.day}"
  end
end
