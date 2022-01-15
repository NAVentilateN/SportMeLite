json.array! @notifications do |notification|
  json.id notification.id
  json.unread !notification.read_at?
  # json.template render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]

  json.sender notification.sender.name
  json.action notification.action
  json.type notification.notifiable.class.to_s.underscore.humanize.downcase
  if notification.notifiable.class.to_s == Message.to_s
    json.url coach_chat_path(notification.notifiable.chat.coach, notification.notifiable.chat, anchor: dom_id(notification.notifiable))
  elsif notification.notifiable.class.to_s == Lesson.to_s
    json.url coach_lessons_path
  end
end
