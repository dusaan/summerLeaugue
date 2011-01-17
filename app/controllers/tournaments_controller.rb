class TournamentsController < ApplicationController
  # GET /tournaments
  # GET /tournaments.xml
  def index
    @tournaments = Tournament.find :all, :conditions => ["sport_id = #{@selected_sport}"], :order => "played desc, starts_at"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tournaments }
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.xml
  def show
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.xml
  def new
    @tournament = Tournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id])
  end

  def edit_tournament_teams
    @tournament = Tournament.find(params[:tournament_id])
    @tournament_teams = @tournament.teams
    ids = ""
    @tournament_teams.collect {|team| ids << " AND id <> #{team.id}"}
    @other_teams = Team.find :all, :conditions => ["sport_id = ? #{ids}", @tournament.sport_id]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end
  
  def tournament_team_add
    team = Team.find(params[:team_id])
    tournament = Tournament.find(params[:tournament_id])
    team.tournaments << tournament
    team.save
    redirect_to edit_tournament_teams_path(tournament)
  end

  def remove_tournament_team
    x = TeamsTournament.find :first, :conditions=> ["team_id =? AND tournament_id = ?", params[:team_id],params[:tournament_id]]
    x.destroy
    redirect_to edit_tournament_teams_path(params[:tournament_id])
  end

  # POST /tournaments
  # POST /tournaments.xml
  def create
    @tournament = Tournament.new(params[:tournament].except(:time))
    @tournament.starts_at = Time.parse("#{params[:tournament][:starts_at]} #{params[:tournament][:time][:hour]}:#{params[:tournament][:time][:minute]}") + 1.hour
    @tournament.user_id = @current_user.id
    @tournament.sport_id = @selected_sport
  
    respond_to do |format|
      if @tournament.save
        flash[:notice] = 'Turnaj bol úspešne vytvorený.'
        format.html { redirect_to(@tournament) }
        format.xml  { render :xml => @tournament, :status => :created, :location => @tournament }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tournament.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tournaments/1
  # PUT /tournaments/1.xml
  def update
    @tournament = Tournament.find(params[:id])
    @tournament.starts_at = Time.parse("#{params[:tournament][:starts_at]} #{params[:tournament][:time][:hour]}:#{params[:tournament][:time][:minute]}") + 1.hour

    respond_to do |format|
      if @tournament.update_attributes(params[:tournament].except(:time))
        flash[:notice] = 'Turnaj bol úspešne zmenený.'
        format.html { redirect_to(@tournament) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tournament.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.xml
  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy

    respond_to do |format|
      format.html { redirect_to(tournaments_url) }
      format.xml  { head :ok }
    end
  end
end
