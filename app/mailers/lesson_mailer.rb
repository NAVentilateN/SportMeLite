class LessonMailer < ApplicationMailer
    def lesson_confirmation(lesson)
        @lesson = lesson
        mail(
          to:       lesson.coach.email,
          subject:  "Lesson #{@lesson.id} has been booked."
        )
    end

    def lesson_deleted(lesson)
        @lesson = lesson
        mail(
          to:       @lesson.coach.email,
          subject:  "Lesson #{@lesson.id} has been cancelled by #{lesson.coach.name}"
        )
    end
end
