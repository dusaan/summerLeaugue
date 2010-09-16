# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate
#  layout :based_on_authentication

  def based_on_authentication
    @current_user = current_user if signed_in?
    @timezone = TimeZone.new('UTC')
    signed_in? ? 'application' : 'anonymous'
  end

end
