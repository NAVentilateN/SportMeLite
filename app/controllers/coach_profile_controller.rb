class CoachProfileController < ApplicationController
  def show
    @user = current_user
    @coach_profile = Coach_profile.find(params[:id])
  end

  def new
    @coach_profile = Coach_profile.new
  end

  def create
    @coach_profile = Coach_profile.new(coach_profile_params)
    if @coach_profile.save
      redirect_to @coach_profile
    else
      render :new
    end
  end

  def edit
    @coach_profile = Coach_profile.find(params[:id])
    @exists = true
  end

  def update
    @coach_profile = Coach_profile.find(params[:id])
    @coach_profile.update(coach_profile_params)

    redirect_to coach_profile_path(@coach_profile)
  end

  private

  def coach_profile_params
    params.require(:coach_profile).permit(:coach_start_date, :description, :sport_id)
  end
end
