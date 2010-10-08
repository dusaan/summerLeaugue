module Authentication

  include Security

  def signed_in?
    current_user != nil
  end

  def current_user
    @current_user ||= login_from_session || nil
  end

  def selected_sport
    @selected_sport = session[:selected_sport_id] || nil
  end

  protected

  def current_user=(user)
    session[:user_id] = user ? user.id : nil
    @current_user = user
  end

  def authenticate
   logger.error "Signed in? #{signed_in?}"
    if !signed_in?
      respond_to do |format|
        format.html do
          session[:return_to] = request.request_uri
          redirect_to new_session_path
        end
      end
    end
  end
private
  def login_from_session
    Thread.current[:user] = User.find_by_id(session[:user_id]) if session[:user_id]
  end
end
