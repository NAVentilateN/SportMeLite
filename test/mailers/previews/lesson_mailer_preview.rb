# Preview all emails at http://localhost:3000/rails/mailers/lesson_mailer
class LessonMailerPreview < ActionMailer::Preview
    def lesson_deleted
        @lesson = Lesson.first
        LessonMailer.lesson_deleted(@lesson)
    end

    def lesson_booked
        @lesson = Lesson.first
        LessonMailer.lesson_booked(@lesson)
    end

    def lesson_confirmation
        @lesson = Lesson.first
        LessonMailer.lesson_confirmation(@lesson)
    end
end
