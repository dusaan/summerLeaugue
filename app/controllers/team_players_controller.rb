class TeamPlayersController < ApplicationController
  # GET /team_players
  # GET /team_players.xml
  def index
    @team_players = TeamPlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_players }
    end
  end

  # GET /team_players/1
  # GET /team_players/1.xml
  def show
    @team_player = TeamPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_player }
    end
  end

  # GET /team_players/new
  # GET /team_players/new.xml
  def new
    @team_player = TeamPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_player }
    end
  end

  # GET /team_players/1/edit
  def edit
    @team_player = TeamPlayer.find(params[:id])
  end

  # POST /team_players
  # POST /team_players.xml
  def create
    @team_player = TeamPlayer.new(params[:team_player])

    respond_to do |format|
      if @team_player.save
        flash[:notice] = 'TeamPlayer was successfully created.'
        format.html { redirect_to(@team_player) }
        format.xml  { render :xml => @team_player, :status => :created, :location => @team_player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_players/1
  # PUT /team_players/1.xml
  def update
    @team_player = TeamPlayer.find(params[:id])

    respond_to do |format|
      if @team_player.update_attributes(params[:team_player])
        flash[:notice] = 'TeamPlayer was successfully updated.'
        format.html { redirect_to(@team_player) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_players/1
  # DELETE /team_players/1.xml
  def destroy
    @team_player = TeamPlayer.find(params[:id])
    @team_player.destroy

    respond_to do |format|
      format.html { redirect_to(team_players_url) }
      format.xml  { head :ok }
    end
  end
end
