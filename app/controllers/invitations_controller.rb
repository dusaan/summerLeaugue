class InvitationsController < ApplicationController
  
  def accept
    return if params[:invitation_id].blank? 
    invitation = Invitation.find(params[:invitation_id])
    return if invitation.user_id != @current_user.id
    user = invitation.user
    user.invite_existing_to(invitation.team)    
    user.save
    invitation.destroy
    redirect_to user_path(user)
  end

  def decline
    return if params[:invitation_id].blank? 
    invitation = Invitation.find(params[:invitation_id])
    return if invitation.user_id != @current_user.id
    invitation.destroy
    redirect_to user_path(@current_user)
  end


end
