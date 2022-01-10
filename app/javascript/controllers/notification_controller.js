import { Controller } from "stimulus";

const notifications = document.querySelector("#notifications");
const url = '/notifications.json';
const notificationDetails = document.querySelector("#dropdownNotificationDetails");

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
        console.log(data.length);

        if (data.length > 0) {
          console.log('there are new messages');
          const allSenders = [];
          let allNotifications = ``;

          data.forEach(element => {
            const sender = element["sender"];
            const action = element["action"];
            const url = element["url"];
            const id = element["id"];

            if (!allSenders.includes(sender)) {
              console.log('populating the notifications dropdown');
              console.log('current allsenders:', allSenders);
              console.log('sender:', sender);
              const newNotification = `<a class="dropdown-item" href="${url}" id="${id}" data-sender="${sender}" data-action="click->notification#markRead">${action} ${sender}</a>`;
              allNotifications += newNotification;
              this.notificationDetailsTarget.innerHTML = allNotifications;
              // this.notificationDetailsTarget.insertAdjacentHTML('beforeend', newNotification);
              allSenders.push(sender);
              // console.log('new allsenders', allSenders);
            } else {
              this.notificationDetailsTarget.innerHTML = allNotifications;
              // console.log('hitting something else instead');
            }
          });
          this.unreadCountTarget.innerText = `${data.length}`;
        } else {
          this.unreadCountTarget.innerText = '';
          this.notificationDetailsTarget.innerHTML = '<span class="dropdown-item">No new notifications.</span>';
        }
      })
  };

  getNewNotifications = () => {
    // console.log('getting new notifications');
    this.loadNotifications();
  };

  markRead(event) {
    // console.log("mark notification as read");
    const currentNotif = event.currentTarget.id;
    const markReadUrl = `/notifications/${currentNotif}/mark_as_read`

    fetch(markReadUrl, {
      method: "POST",
      body: JSON.stringify({ query: event.currentTarget.value })
    })
      .then(response => response.json())
      .then((data) => {
        // post method above will mark notification as read, nothing more to do here
      });
  }
};
