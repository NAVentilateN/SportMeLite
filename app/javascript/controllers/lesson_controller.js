import { Controller } from "stimulus";
import { calendar, googleEvents } from "../packs/calendar";
import { initMapbox } from "../plugins/init_mapbox";

export default class extends Controller {
  static targets = [
    "card",
    "modalContent",
    "lessonModal",
    "editForm",
    "newBtn",
    "newForm",
    "list",
    "lessonsList",
  ];

  // connect () {
  //   console.log(this.modalContentTarget)
  //   console.log(this.cardTarget)
  //   console.log(this.newBtnTarget)
  // console.log(this.listTarget)
  //   console.log(this.modalContentShowTarget)
  // console.log(this.lessonsListTarget)
  //   console.log(this)
  // }

  toggleGoogleEvents() {
    if ($(".checkbox").prop("checked")) {
      calendar.addEventSource(googleEvents);
    } else {
      const googleEventsSource = calendar.getEventSources()[1];
      if (googleEventsSource) {
        googleEventsSource.remove();
      }
    }
  }

  toggleSyncEventToGoogle() {
    const syncUrl = `/coach/lessons/${$("#syncEventToGoogleCheckbox").attr(
      "data-lesson-id"
    )}/sync_to_google`;
    const unsyncUrl = `/coach/lessons/${$("#syncEventToGoogleCheckbox").attr(
      "data-lesson-id"
    )}/unsync_from_google`;
    if ($("#syncEventToGoogleCheckbox").prop("checked")) {
      fetch(syncUrl);
    } else {
      fetch(unsyncUrl);
    }
  }

  //show lesson method
  displayShowForm(e) {
    e.preventDefault();
    const url = e.currentTarget.getAttribute('href'); //use currentTarget.href does not work for monthlist events
    if (url) {
      const splitUrlArr = url.split("/");
      const lessonId = url.split("/")[splitUrlArr.length - 1];
      if (Number.isInteger(+lessonId)) {  //this condition checks if the event is a google calendar fetched event
        fetch(url, {
          method: "GET",
          headers: { Accept: "text/plain" },
        })
          .then((response) => response.text())
          .then((data) => {
            this.modalContentTarget.innerHTML = data;
            $("#lessonModal").modal("show");

            initMapbox();
          });
      }
    }
  }

  //edit lesson methods
  displayEditForm(e) {
    const url = e.currentTarget.href;
    fetch(url, {
      method: "GET",
      headers: { Accept: "text/plain" },
    })
      .then((response) => response.text())
      .then((data) => {
        this.modalContentTarget.innerHTML = data;
        $("#lessonModal").modal("show");
      });
  }

  // update(event) {
  //   event.preventDefault();
  //   const lessonId = this.editFormTarget.action.split("/")[5];
  //   const cardTarget = this.cardTargets.find(
  //     (cardEl) => cardEl.dataset.id === lessonId
  //   );
  //   const startDateTime = $("#lesson_start_date_time").val();
  //   const endDateTime = $("#lesson_end_date_time").val();
  //   const lessonDescription = $("#lesson_description").val();
  //   const url = this.editFormTarget.action;
  //   fetch(url, {
  //     method: "PATCH",
  //     headers: { Accept: "text/plain" },
  //     body: new FormData(this.editFormTarget),
  //   })
  //     .then((response) => response.text())
  //     .then((data) => {
  //       cardTarget.outerHTML = data;
  //       //updating the calendar
  //       calendar.getEventById(lessonId).remove();
  //       calendar.addEvent({
  //         id: lessonId,
  //         start: new Date(startDateTime),
  //         end: new Date(endDateTime),
  //         title: lessonDescription,
  //         backgroundColor: "red",
  //         textColor: "white",
  //         extendedProps: {
  //           description: lessonDescription,
  //         },
  //       });
  //       $("#lessonModal").modal("hide");
  //     });
  // }

  //navlink lesson methods
  displayLessons(e) {
    const url = e.currentTarget.href;
    fetch(url, {
      method: "GET",
      headers: { Accept: "text/plain" },
    })
      .then((response) => response.text())
      .then((data) => {
        this.lessonsListTarget.outerHTML = data;
      });
    if (e.currentTarget.classList.contains("lesson-header-link")) {
      $(".lesson-header-link.active").removeClass("active");
      e.currentTarget.classList.add("active");
    }
  }
}

//new lesson methods
// displayNewForm(event) {
//   event.preventDefault();
//   const url = this.newBtnTarget.href
//   fetch(url, {
//     method: 'GET',
//     headers: { 'Accept': 'text/plain' },
//   }).then(response =>
//     response.text())
//   .then((data) => {
//     this.modalContentTarget.innerHTML = data
//   })
//   $('#lessonModal').modal('show');
// }

//   create(event) {
//     event.preventDefault();
//     const url = this.newFormTarget.action
//     fetch(url, {
//       method: 'POST',
//       headers: { 'Accept': 'text/plain' },
//       body: new FormData(this.newFormTarget)
//     })
//       .then(response => {
//         response.text()})
//       .then((data) => {
//         this.listTarget.outerHTML = data;
//       })
//   }
