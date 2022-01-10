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
        console.log(data.length);
        if (data.length > 0) {
          // this.notificationDetailsTarget.innerHTML = ``;
          // const placeholderText = `<span class="dropdown-item">No new notifications.</span>`;
          // this.notificationDetailsTarget.innerHTML = ``;
          console.log('there are new messages');
          data.forEach(element => {
            const sender = element["sender"];
            const action = element["action"];
            const url = element["url"];
            const id = element["id"];

            if (!allSenders.includes(sender)) {
              console.log('allsenders:', allSenders);
              console.log('sender:', sender);
              const newNotification = `<a class="dropdown-item" href="${url}" id="${id}" data-sender="${sender}" data-action="click->notification#markRead">${action} ${sender}</a>`;
              this.notificationDetailsTarget.insertAdjacentHTML('beforeend', newNotification);
              allSenders.push(sender);
            }

            // if (allSenders.includes(sender)) {
            //   console.log("sender alr exists in array", allSenders);
            //   this.notificationDetailsTarget.innerHTML = allNotifications;
            // } else {
            // console.log("added new sender to senders array", allSenders);
            // const newNotification = `<a class="dropdown-item" href="${url}" id="${id}" data-sender="${sender}" data-action="click->notification#markRead">${action} ${sender}</a>`
            // allNotifications += newNotification;
            // this.notificationDetailsTarget.innerHTML = allNotifications;
            // if (allSenders.includes(sender)) {
            //   allSenders;
            // } else {
            //   allSenders.push(sender);
            // }
            // }
          });
        }

        // update unreadCount to length
        if (data.length === 0) {
          this.unreadCountTarget.innerText = '';
          this.notificationDetailsTarget.innerHTML = '<span class="dropdown-item">No new notifications.</span>';
        } else {
          this.unreadCountTarget.innerText = `${data.length}`;
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
    const sender = event.currentTarget.dataset.sender;
    console.log(sender);
    const currentNotifHTML = String(event.currentTarget);
    const markReadUrl = `/notifications/${currentNotif}/mark_as_read`
    const senderIndex = allSenders.indexOf(sender);
    console.log('replacing this:', currentNotifHTML);

    fetch(markReadUrl, {
      method: "POST",
      body: JSON.stringify({ query: event.currentTarget.value })
    })
      .then(response => response.json())
      .then((data) => {
        // remove sender from array
        if (senderIndex !== -1) {
          allSenders.splice(senderIndex, 1);
          if (allSenders.length === 0) {
            this.notificationDetailsTarget.innerHTML = '<span class="dropdown-item">No new notifications.</span>';
          }
          console.log('sender should be removed:', allSenders);
        }
        // remove substring from allNotifications
        console.log('before:', allNotifications);
        // allNotifications.replace(currentNotifHTML, '');
        console.log('replaced dropdown list looks like this:', currentNotifHTML);
      });
  }
};
//
