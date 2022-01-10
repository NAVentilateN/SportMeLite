# Preview all emails at http://localhost:3000/rails/mailers/lesson_mailer
class LessonMailerPreview < ActionMailer::Preview
    def lesson_deleted
        @lesson = Lesson.last
        LessonMailer.lesson_deleted(@lesson, @lesson.student)
    end

    def lesson_confirmation
        @lesson = Lesson.last
        LessonMailer.lesson_confirmation(@lesson)
    end
end
