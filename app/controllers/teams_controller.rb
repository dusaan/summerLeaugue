class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.xml
  skip_before_filter :verify_authenticity_token, :only => [:invite_submit]

  def index
    @teams = Team.all
    @selected_sport_name = (Sport.find params[:sport]).name if params[:sport]
    @selected_sport = params[:sport] if params[:sport]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  def remove_user
    if params[:team_id].blank? || params[:user_id].blank?
      redirect_to teams_path
      return
    end
    team = Team.find_by_id params[:team_id]
    unless (team.nil? || team.user_id != @current_user.id || @current_user.id.to_s == params[:user_id])
      team_player = TeamPlayer.find :first, :conditions => ["team_id = #{params[:team_id]} AND user_id = #{params[:user_id]}"]
      team_player.destroy
    end
    redirect_to team
    
  end

  def suggest
	    @token = params[:name].ascii
	    @teams = Team.find :all, :conditions => ["' ' || ascii_name like ?", "% #{@token}%"], :order => 'name', :limit => 20
	    render :layout => false
	  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end
  
  def invite
    @team = Team.find(params[:team_id])
    redirect_to teams_path if @current_user.id != @team.user_id
  end

  def invite_submit
    @team = Team.find(params[:team_id])
    redirect_to teams_path if @current_user.id != @team.user_id || params[:email].blank?
    user = User.new :email=> params[:email]
    user.invite_to(@team)
    user.save
    redirect_to (@team)
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team])

    @team.sport_id = @selected_sport
    @team.user_id = @current_user.id
    @current_user.sports << @team.sport
    @current_user.sports.uniq
    @current_user.save
    @team.users << @current_user
    respond_to do |format|
      if @team.save
        flash[:notice] = 'Tím bol úspšne vytvorený.'
        format.html { redirect_to(@team) }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        flash[:notice] = 'Tím bol úspšne zmenený.'
        format.html { redirect_to(@team) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end
end
