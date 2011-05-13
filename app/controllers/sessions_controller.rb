class SessionsController < ApplicationController

  # ssl_required :new, :create

  skip_before_filter :authenticate, :only => [:new, :create, :update_selected_sport]
  skip_before_filter :verify_authenticity_token, :only => [:new, :create]

  def new
    redirect_to user_path(current_user) if signed_in?
    #@user_credential = UserCredential.new
  end

  def create
    if signed_in?
      redirect_to user_path(current_user)
      return
    end
    login = params[:login]
    password = params[:password]
    unless (login.blank? || password.blank?)
      self.current_user = User.authenticate(login, password)
      flash[:notice] ="Vitaj #{current_user.name}!" unless current_user.nil?
      redirect_to user_path(current_user) unless current_user.nil?
      return unless current_user.nil?
    end
    flash[:error] ="Nesprávne meno alebo heslo, prípadne nebolo aktivované konto"
    render :action => 'new'
  end


  def destroy
    reset_session
    redirect_to default_path
  end
  
  def update_selected_sport
    if (!params[:sport].blank?)
      session[:selected_sport_id] = params[:sport] 
      if params[:sport] != "0"
        sport = Sport.find params[:sport] 
        session[:selected_sport_name] = sport.nil? ? "" : sport.name
        #redirect_to news_path(params[:sport]) 
        redirect_to sport.team ? teams__path(params[:sport]) : users__path(params[:sport])
      else
        session[:selected_sport_name] = session[:selected_sport_id] = nil
        redirect_to default_path
      end
    else
      redirect_to default_path
    end
  
  end


end
