class ChatsController < ApplicationController
  def index
    @chats = Chat.where(coach: current_user).or(Chat.where(student: current_user))
  end

  def create
    @coach = User.find(params[:coach_id])
    @chat = Chat.new(name: "#{@coach.name}")
    @chat.coach = @coach
    @chat.student = current_user
    @chat.save
    redirect_to coach_chat_path(@coach, @chat)
  end

  def show
    @chat = Chat.find(params[:id])
    @coach = User.find(params[:coach_id])
    @message = Message.new
  end
end
