module Coach
  class CoachProfilesController < ApplicationController
    def show
      @user = current_user
      @coach_profile = CoachProfile.find(params[:id])
    end

    def edit
      @coach_profile = CoachProfile.find(params[:id])
      @user = current_user
      @exists = true
      # authorize @coach_profile
    end

    def update
      @coach_profile = CoachProfile.find(params[:id])
      @coach_profile.update(coach_profile_params)
      @user = current_user

      if @coach_profile.save
        redirect_to coach_coach_profile_path(@coach_profile)
      else
        render :new
      end
      # authorize @coach_profile
    end

    def destroy
      @user = current_user
      @user.coach_profile.destroy
      @user.save!
      redirect_to user_path(@user)

      # authorize @coach_profile
    end

    private

    def coach_profile_params
      params.require(:coach_profile).permit(:coach_start_date, :description, :sport, :user, :sport_id, :user_id, photos: [])
    end
  end
end
