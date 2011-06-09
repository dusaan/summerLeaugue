class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  skip_before_filter :authenticate, :only => [:new, :create, :join_league]

  def index
   sport = Sport.find  @selected_sport
    @users = sport.nil? ? [] : sport.users
    @is_playing = !(@users.blank? || (@users.find_by_id @current_user.id).nil?)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def index_admin
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

  end

  # GET /users/new
  # GET /users/new.xml
  def register
    @user = User.new 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  #User join   
  def join
    @current_user.sports << (Sport.find @selected_sport)
    @current_user.save
    redirect_to(@current_user) 
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def join_league
    @user = User.find_by_register_link(params[:join_string])
    redirect_to new_user_path unless @user
    @user.register_link = nil
    @user.save
    flash[:notice] = 'Vítame Ťa na portáli aLiga.SK! Tvoje konto bolo aktivované, teraz sa môžeš prihlásiť'
    redirect_to edit_user_path(@user)
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    saved = false;
    respond_to do |format|
	      if @user.save
	        flash[:notice] = 'Vítame Ťa na portáli aLiga.SK Po aktivivacii stranky dostanes email, bude v ňom link na potvrdenie registrácie'
          format.html { redirect_to invite_temp_path }
 #         format.html { redirect_to new_session_path }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Profil bol úspešne zmenený.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
