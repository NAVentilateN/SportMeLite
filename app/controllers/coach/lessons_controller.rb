require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"
require 'date';

module Coach
  class LessonsController < ApplicationController
    CALENDAR_ID = 'primary'
    before_action :set_lesson, only: [:show, :edit, :update, :destroy, :sync_to_google, :unsync_from_google]
    before_action :authorize_coach, only: [:index, :upcoming, :history]
    before_action :set_lesson_new, only: [:index, :upcoming, :history, :new]
    # before_action :get_google_client, except: [:show, :new, :create, :edit, :update, :destroy]

    def index
      client = get_google_calendar_client current_user
      if client
        @events = client.list_events(CALENDAR_ID).items.select{ |event| event.extended_properties.blank?}
        @google_events = @events.map { |event | {
          id: event.id,
          start: event.start.date_time,
          end: event.end.date_time,
          title: event.summary,
        }}.to_json
      end

      all_lessons = current_user.lessons_to_teach
      @lessons_json = all_lessons.map { |lesson| lesson.to_json}
      @pagy, @lessons = pagy(all_lessons
      .where("end_date_time >= ?", Time.now.to_datetime)
      .order(start_date_time: :asc))

      respond_to do |format|
        format.html
        format.text { render partial: 'coach/lessons/lessons_list', formats: [:html]}
      end
    end

    def show
      respond_to do |format|
        format.html
        format.text { render partial: 'coach/lessons/show', locals: { lesson: @lesson }, formats: [:html] }
      end
    end

    def new
      @locations = Location.all.uniq.sort_by(&:name)
      respond_to do |format|
        format.html
        format.text { render partial: 'coach/lessons/new', locals: { lesson: @lesson }, formats: [:html] }
      end
    end

    def create
      @lesson = Lesson.new(lesson_params)
      @lesson.coach = current_user
      @lesson.status = false
      if @lesson.save && params[:lesson][:sync_to_google] == "1"
        client = get_google_calendar_client current_user
        event = create_google_event(@lesson)
        google_event = client.insert_event(CALENDAR_ID, event)
        @lesson.update(google_event_id: google_event.id)
        redirect_to coach_lessons_path 
        flash[:notice] = "New Lesson was created successfully! (Added to Google Calendar)"
      elsif @lesson.save
        redirect_to coach_lessons_path 
        flash[:notice] = "New Lesson was created successfully!"
      else
        render :new
        flash[:alert] = "New Lesson was not created."
      end
    end

    def edit
      respond_to do |format|
        format.html 
        format.text { render partial: 'coach/lessons/edit', locals: { lesson: @lesson }, formats: [:html]  }
      end
    end

    def update
      @lesson.update(lesson_params)
      if @lesson.save
        if @lesson.google_event_id
          client = get_google_calendar_client current_user
          google_event = client.get_event(CALENDAR_ID, @lesson.google_event_id)
          updated_google_event = create_google_event(@lesson)
          client.update_event(CALENDAR_ID, @lesson.google_event_id, updated_google_event)
        end   
        redirect_to coach_lessons_path 
        flash[:notice] = "Lesson was edited successfully!"
      else
        render :edit
        flash[:alert] = "Lesson not updated. Please rectify errors and resubmit."
      end
    end

    def destroy
      if @lesson.order || @lesson.review
        redirect_to coach_lessons_path
        flash[:alert] = "You can't delete a lesson taht is booked!"
      else
        if @lesson.google_event_id
          client = get_google_calendar_client current_user
          client.delete_event(CALENDAR_ID, @lesson.google_event_id) unless client.get_event(CALENDAR_ID, @lesson.google_event_id).status == 'cancelled' 
        end
        LessonMailer.lesson_deleted(@lesson).deliver_later
        @lesson.destroy
        redirect_to coach_lessons_path
        flash[:notice] = "Lesson was deleted successfully!" 
      end
    end

    def all
      all_lessons = current_user.lessons_to_teach.order(start_date_time: :asc)
      @pagy, @lessons = pagy(all_lessons)
      # all_lessons = current_user.lessons_to_teach
      # @lessons = all_lessons.select{ |lesson| lesson.end_date_time >= Time.now.to_datetime}.sort_by { |lesson| lesson.start_date_time }
      respond_to do |format|
        format.html
        format.text { render partial: 'coach/lessons/lessons_list', formats: [:html] }
      end
    end

    def history
      all_lessons = current_user.lessons_to_teach
      .where("end_date_time < ?", Time.now.to_datetime)
      .order(start_date_time: :asc)
      @pagy, @lessons = pagy(all_lessons)
      # all_lessons = current_user.lessons_to_teach
      # @lessons = all_lessons.select{ |lesson| lesson.end_date_time < Time.now.to_datetime}.sort_by { |lesson| lesson.start_date_time }
        respond_to do |format|
          format.html
          format.text { render partial: 'coach/lessons/lessons_list', formats: [:html] }
        end
    end

    def sync_all_lessons_to_calendar
      client = get_google_calendar_client current_user
      all_lessons = current_user.lessons_to_teach.select {|lesson| lesson.google_event_id.nil?}
      all_lessons.each do |lesson|
        event = create_google_event(lesson)
        google_event = client.insert_event(CALENDAR_ID, event)
        lesson.update(google_event_id: google_event.id)
      end
      redirect_to coach_lessons_path
      flash[:notice] = "All lessons are added to Google Calendar!"
    end

    def remove_all_lessons_from_calendar
      client = get_google_calendar_client current_user
      all_lessons = current_user.lessons_to_teach.select {|lesson| lesson.google_event_id }
      all_lessons.each do |lesson|
        client.delete_event(CALENDAR_ID, lesson.google_event_id) unless client.get_event(CALENDAR_ID, lesson.google_event_id).status == 'cancelled' 
        lesson.update(google_event_id: nil)
      end
      redirect_to coach_lessons_path
      flash[:notice] = "All lessons are removed from Google Calendar!"
    end

    def sync_to_google
      client = get_google_calendar_client current_user
      event = create_google_event(@lesson)
      google_event = client.insert_event(CALENDAR_ID, event)
      @lesson.update(google_event_id: google_event.id)
      redirect_to coach_lessons_path
      flash[:notice] = "Lesson added to Google Calendar!"
    end

    def unsync_from_google
      client = get_google_calendar_client current_user
      client.delete_event(CALENDAR_ID, @lesson.google_event_id) unless client.get_event(CALENDAR_ID, @lesson.google_event_id).status == 'cancelled' 
      @lesson.update(google_event_id: nil)
      redirect_to coach_lessons_path
      flash[:notice] = "Lesson removed from Google Calendar!"
    end

    private

    def lesson_params
      params.require(:lesson).permit(:start_date_time, :end_date_time, :location_id, :price, :description)
      # :sport_id
    end

    def authorize_coach
      policy_scope([:coach, Lesson])
      authorize([:coach, Lesson])
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
      authorize([:coach, @lesson])
    end

    def set_lesson_new
      @lesson = Lesson.new
    end

    def get_google_client
      client = get_google_calendar_client current_user
    end

    def create_google_event(lesson)
      event = Google::Apis::CalendarV3::Event.new({
        summary: lesson.description,
        location: lesson.location.name,
        start: {
          date_time: (lesson.start_date_time.to_time - 8.hours).to_datetime.rfc3339.to_s,
          # time_zone: 'Asia/Singapore', 
        },
        end: {
          date_time: (lesson.end_date_time.to_time - 8.hours).to_datetime.rfc3339.to_s,
          # time_zone: 'Asia/Singapore',  
        },
        organizer: {
          email: current_user.email, 
          displayName: current_user.name, 
        },
        attendees: [],
        reminders: {
          use_default: true
        },
        extended_properties: {
          'private':{
            'lesson_id': "#{lesson.id}"
          } 
        },
        # notification_settings: {
        #   notifications: [
        #                   {type: 'event_creation', method: 'email'},
        #                   {type: 'event_change', method: 'email'},
        #                   {type: 'event_cancellation', method: 'email'},
        #                   {type: 'event_response', method: 'email'}
        #                  ]
        # }, 'primary': true
        # sendNotifications: true,
        # send_updates: true,
        # sendUpdates: 'all'
      })
    end

    def get_google_calendar_client current_user
      client = Google::Apis::CalendarV3::CalendarService.new
      return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)

      secrets = Google::APIClient::ClientSecrets.new({
        "web" => {
          "access_token" => current_user.access_token,
          "refresh_token" => current_user.refresh_token,
          "client_id" => ENV["GOOGLE_CLIENT_ID"],
          "client_secret" => ENV["GOOGLE_CLIENT_SECRET"]
        }
      })
      # try/catch
      begin
        client.authorization = secrets.to_authorization
        client.authorization.grant_type = "refresh_token"
  
        if current_user.expired?
          client.authorization.refresh!

          current_user.update(
            access_token: client.authorization.access_token,
            refresh_token: client.authorization.refresh_token,
            expires_at: client.authorization.expires_at.to_i
          )
        end
      rescue => e
        redirect_to root_path
        flash[:notice] = 'Your token has expired. Please login again with Google.'
      end

      client
    end

  end
end
