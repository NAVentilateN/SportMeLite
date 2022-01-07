import { Controller } from "stimulus";

const notifications = document.querySelector("#notifications");
const url = '/notifications.json';

export default class extends Controller {
  static targets = [
    "notificationButton",
    "unreadCount",
    "notifications"
  ];

  connect() {
    console.log("aloha");
    // console.log("notifications are here:", notifications);
    // console.log(this.notificationButtonTarget);
    // console.log(this.unreadCountTarget);
    if (notifications) {
      this.loadNotifications();
      setInterval(this.getNewNotifications(), 5000);
    };
  };

  loadNotifications() {
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        // to do:
        // o/s resolve navbar dropdown not working in localhost
        // o/s resolve new notifications not being created
        // parse data and insert each notification as adjacent HTML to notifications
      })
  };

  getNewNotifications() {
    console.log('getting new notifications');
    this.loadNotifications();
  };

  markRead(event) {
    console.log("clearing new notifications", this.unreadCountTarget);
    const markReadUrl = "/notifications/mark_as_read"

    fetch(markReadUrl, {
      method: "POST",
      body: JSON.stringify({ query: event.currentTarget.value })
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        // reset unread count to empty string
        this.unreadCountTarget.innerText = "";
      });
  };
};
