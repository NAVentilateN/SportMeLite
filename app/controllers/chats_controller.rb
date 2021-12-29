class ChatsController < ApplicationController
  def index
    @chats = Chat.where(coach: current_user).or(Chat.where(student: current_user))
    @sorted_chats = @chats.joins(:messages).order('messages.created_at DESC').uniq
  end

  def create
    @coach = User.find(params[:coach_id])
    if Chat.between(current_user, @coach).present?
      @chat = Chat.between(current_user, @coach).first
    else
      @chat = Chat.new(name: "#{@coach.name}")
      @chat.coach = @coach
      @chat.student = current_user
      @chat.save
    end
    redirect_to coach_chat_path(@coach, @chat)
  end

  def show
    @chat = Chat.find(params[:id])
    @coach = User.find(params[:coach_id])
    @message = Message.new
  end
end
