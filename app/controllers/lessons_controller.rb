class LessonsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @lessons = current_user.lessons_to_attend
  end

  
end
