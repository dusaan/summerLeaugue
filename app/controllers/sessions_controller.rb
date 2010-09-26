class SessionsController < ApplicationController

  # ssl_required :new, :create

  skip_before_filter :authenticate, :only => [:new, :create]
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
      logger.debug "User: #{current_user.inspect}"
      redirect_to user_path(current_user) unless current_user.nil?
      return unless current_user.nil?
    end
    logger.debug "Sign in failed"
    flash[:error] ="Sign in failed"
    render :action => 'new'
  end


  def destroy
    reset_session
    redirect_to default_path
  end
  
  def update_selected_sport
    if (!params[:sport].blank? && @selected_sport != params[:sport])
      session[:selected_sport_id] = params[:sport] 
      
    end
  redirect_to news_path(params[:sport])
  end


end
