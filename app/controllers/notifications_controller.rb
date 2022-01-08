class NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @notifications = Notification.where(recipient: current_user).unread
  end

  def mark_as_read
    # @notifications = Notification.where(recipient: current_user).unread
    @notification = Notification.find(params[:id])
    @notification.update(read_at: Time.zone.now)
    render json: { success: true }
  end
end
