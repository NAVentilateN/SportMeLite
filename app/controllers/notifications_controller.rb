class NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @notifications = Notification.where(recipient: current_user).unread
  end

  def mark_as_read
    # @notifications = Notification.where(recipient: current_user).unread
    @notification = Notification.find(params[:id])
    @sender = @notification.sender
    @notifications = Notification.where(sender: @sender)
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
