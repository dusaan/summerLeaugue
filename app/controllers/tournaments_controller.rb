class TournamentsController < ApplicationController
  skip_before_filter :authenticate, :only => [:show_public, :show_with_name]

  # GET /tournaments
  # GET /tournaments.xml
  def index
    @tournaments = Tournament.find :all, :conditions => ["sport_id = #{@selected_sport}"], :order => "played desc, starts_at"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tournaments }
    end
  end

  def show_with_name
    sport = Sport.find_by_name (params[:name])
    redirect_to default_path if sport.nil? 
    return if sport.nil? 
    @tournament = sport.tournaments.first
    redirect_to default_path if @tournament.nil?
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  def show_public
    @tournament = Tournament.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tournament }
    end
  end
  # GET /tournaments/1
  # GET /tournaments/1.xml
  def show
    @tournament = Tournament.find(params[:id])
    @team = @tournament.teams.find :first, :conditions =>["user_id = #{@current_user.id}"] if @current_user
    @should_confirm = true if( @team && (TeamsTournament.find :first, :conditions =>["team_id = ? AND tournament_id = ? AND confirmed = false", @team.id, params[:id]]))
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  def tournament_matches
    @tournament = Tournament.find(params[:tournament_id])
    @matches = @tournament.matches;
    @time = Time.now
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end

  def generate_tournament_mathces
    @tournament = Tournament.find(params[:tournament_id])
    return unless @tournament.user_id == @current_user.id
    @tournament.generate_matches
    flash[:notice] = 'Zápasy boli úspešne pregenerované.'
    redirect_to tournament_path(@tournament)
  end
  # GET /tournaments/new
  # GET /tournaments/new.xml
  def new
    redirect_to tournaments_path unless @current_user.admin?
    return unless @current_user.admin?
    @tournament = Tournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id])
    redirect_to default_path unless (@current_user.id == @tournament.user_id || @current_user.admin?)

  end

  def edit_tournament_teams
    @tournament = Tournament.find(params[:tournament_id])
    @tournament_teams_confirmed = @tournament.teams.find :all, :conditions => ["confirmed = ?",true]
    @tournament_teams_not_confirmed = @tournament.teams.find :all, :conditions => ["confirmed = ?",false]
    ids = ""
    @tournament_teams_confirmed.collect {|team| ids << " AND id <> #{team.id}"}
    @tournament_teams_not_confirmed.collect {|team| ids << " AND id <> #{team.id}"}
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

  def tournament_team_confirm
    x = TeamsTournament.find :first, :conditions=> ["team_id =? AND tournament_id = ?", params[:team_id],params[:tournament_id]]
    x.confirmed = true
    x.save
    redirect_to(:back)
  end

  def remove_tournament_team
    x = TeamsTournament.find :first, :conditions=> ["team_id =? AND tournament_id = ?", params[:team_id],params[:tournament_id]]
    x.destroy
    redirect_to(:back) 

    end

  # POST /tournaments
  # POST /tournaments.xml
  def create
    @tournament = Tournament.new(params[:tournament].except(:time))
#    @tournament.starts_at = Time.parse("#{params[:tournament][:starts_at]} #{params[:tournament][:time][:hour]}:#{params[:tournament][:time][:minute]}") + 1.hour
    @tournament.user_id = @current_user.id
    @tournament.sport_id = @selected_sport
  
    respond_to do |format|
      if @tournament.save 
        Newz.create :sport =>@tournament.sport, :header=>"Nový turnaj", :text=>"Používateľ #{@current_user.name} vytvoril nový turnaj s názvom #{@tournament.name}. Odohrá sa #{@tournament.starts_at.strftime("%d.%m.%Y o %H:%M")}, viac info v sekcii turnaje."
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
 #   @tournament.starts_at = Time.parse("#{params[:tournament][:starts_at]} #{params[:tournament][:time][:hour]}:#{params[:tournament][:time][:minute]}") + 1.hour

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
