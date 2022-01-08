import { Controller } from "stimulus";

const notifications = document.querySelector("#notifications");
const url = '/notifications.json';
const notificationDetails = document.querySelector("#dropdownNotificationDetails");
let allSenders = [];
let allNotifications = ``;

export default class extends Controller {
  static targets = [
    "notificationButton",
    "unreadCount",
    "notifications",
    "notificationDetails"
  ];

  connect() {
    console.log("aloha");
    if (notifications) {
      this.loadNotifications();
      setInterval(this.getNewNotifications, 8000);
    };
  };

  loadNotifications() {
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        // parse data and replace notificationDetailsTarget with updated allNotifications
        data.forEach(element => {
          const sender = element["sender"];
          const action = element["action"];
          const url = element["url"];
          if (allSenders.includes(sender)) {
            // console.log("sender alr exists in array", allSenders);
            this.notificationDetailsTarget.innerHTML = allNotifications;
          } else {
            // console.log('added new sender to senders array', allSenders);
            const newNotification = `<a class="dropdown-item" href="${url}">${action} ${sender}</a>`
            allNotifications += newNotification;
            this.notificationDetailsTarget.innerHTML = allNotifications;
            allSenders.push(sender);
          }
        });
        // update unreadCount to length
        if (data.length == 0) {
          this.unreadCountTarget.innerText = '';
          this.notificationDetailsTarget.innerHTML = `<span class="dropdown-item">No new notifications</span`;
        } else {
          this.unreadCountTarget.innerText = `${data.length}`;
        }
      })
  };

  getNewNotifications = () => {
    console.log('getting new notifications');
    this.loadNotifications();
  };

  markRead(event) {
    console.log("view new notifications and clear count", this.unreadCountTarget);
    const markReadUrl = "/notifications/mark_as_read"

    fetch(markReadUrl, {
      method: "POST",
      body: JSON.stringify({ query: event.currentTarget.value })
    })
      .then(response => response.json())
      .then((data) => {
        // reset unread count to empty string
        this.unreadCountTarget.innerText = "";
        // clear senders array
        allSenders = [];
        // clear notifications dropdown
        // this.notificationDetailsTarget.innerHTML = `<span class="dropdown-item">No new notifications</span`;
      });
  };
};
