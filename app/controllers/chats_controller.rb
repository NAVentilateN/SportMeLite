class ChatsController < ApplicationController
  def create
    @coach = User.find(params[:coach_id])
    @chat = Chat.new(name: "#{@coach.name}")
    @chat.save
    redirect_to coach_chat_path(@coach, @chat)
  end

  def show
    @chat = Chat.find(params[:id])
    @coach = User.find(params[:coach_id])
    @message = Message.new
  end
end
