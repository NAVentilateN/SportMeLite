json.array! @notifications do |notification|
  # json.id notification.id
  # json.unread !notification.read_at?
  # json.template render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]

  json.recipient notification.recipient
  json.sender notification.sender
  json.action notification.action
  json.notifiable do #notification.notifiable
    json.type "New #{notification.notifiable.class.to_s.underscore.humanize.downcase} from"
  end
  json.url coach_chat_path(notification.notifiable.chat.coach, notification.notifiable.chat, anchor: dom_id(notification.notifiable))
end
