class ReviewsController < ApplicationController

  def new
      @review = Review.new
      @lesson = Lesson.find(params[:lesson_id])
    end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @review = Review.new(review_params)
    @student = current_user
    @review.lesson = @lesson
    @review.coach = @lesson.coach
    @review.student = @student


    if @review.save
      redirect_to lessons_path
    else
      render :new
    end
  end

   private

  def review_params
    params.require(:review).permit(:content)
  end
end
