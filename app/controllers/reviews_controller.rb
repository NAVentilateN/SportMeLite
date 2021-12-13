class ReviewsController < ApplicationController

  def new
      @review = Review.new
      @lesson = Lesson.find(params[:lesson_id])
    end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @review = Review.new(review_params)
    @review.lesson = @lesson
    @review.student = current_user

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
