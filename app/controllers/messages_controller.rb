class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @coach = User.find(params[:coach_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.user = current_user
    if @message.save
      # create the notification
      if @chat.users.uniq.count == 1
        Notification.create(recipient: @coach, sender: current_user, action: "New message from", notifiable: @message)
      else
        (@chat.users.uniq - [current_user]).each do |user|
          Notification.create(recipient: user, sender: current_user, action: "New message from", notifiable: @message)
        end
      end

      ChatChannel.broadcast_to(
        @chat,
        render_to_string(partial: "message", locals: { message: @message })
      )

      redirect_to coach_chat_path(@coach, @chat, anchor: "message-#{@message.id}")
    else
      render "chats/show"
    end
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
end
