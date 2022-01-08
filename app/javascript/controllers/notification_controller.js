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
          const id = element["id"];
          if (allSenders.includes(sender)) {
            // console.log("sender alr exists in array", allSenders);
            this.notificationDetailsTarget.innerHTML = allNotifications;
          } else {
            // console.log("added new sender to senders array", allSenders);
            const newNotification = `<a class="dropdown-item" href="${url}" id="${id}" data-sender="${sender}" data-action="click->notification#markRead">${action} ${sender}</a>`
            allNotifications += newNotification;
            this.notificationDetailsTarget.innerHTML = allNotifications;
            allSenders.push(sender);
          }
        });
        // update unreadCount to length
        if (data.length == 0) {
          this.unreadCountTarget.innerText = '';
        } else {
          this.unreadCountTarget.innerText = `${data.length}`;
        }
      })
  };

  getNewNotifications = () => {
    console.log('getting new notifications');
    this.loadNotifications();
    console.log('allsenders', allSenders);
  };

  markRead(event) {
    console.log("mark notification as read");
    const currentNotif = event.currentTarget.id;
    const sender = event.currentTarget.dataset.sender;
    const notifHTML = event.currentTarget;
    const markReadUrl = `/notifications/${currentNotif}/mark_as_read`
    const senderIndex = allSenders.indexOf(sender);

    fetch(markReadUrl, {
      method: "POST",
      body: JSON.stringify({ query: event.currentTarget.value })
    })
      .then(response => response.json())
      .then((data) => {
        console.log('sender:', sender);
        // remove sender from array
        if (senderIndex !== -1) {
          allSenders.splice(senderIndex, 1);
        }
        console.log(allSenders);
        // remove substring from allNotifications
        allNotifications.replace(notifHTML, '');
        console.log(allNotifications);
      });
  }
};
