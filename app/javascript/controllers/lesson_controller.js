import { Controller } from "stimulus";
import { calendar, googleEvents } from "../packs/calendar";

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
    const syncUrl = `/coach/lessons/${$("#syncEventToGoogleCheckbox").attr('data-lesson-id')}/sync_to_google`
    const unsyncUrl = `/coach/lessons/${$("#syncEventToGoogleCheckbox").attr('data-lesson-id')}/unsync_from_google`
    if ($("#syncEventToGoogleCheckbox").prop("checked")) {
      console.log('sync')
      fetch(syncUrl)
      } else {
      console.log('unsync')
      fetch(unsyncUrl)
    }
  }

  //show lesson method
  displayShowForm(e) {
    e.preventDefault();
    const url = e.currentTarget.href;
    const lessonId = url.split("/")[5];
    if (Number.isInteger(+lessonId)) {
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
    $(".lesson-header-link.active").removeClass("active");
    e.currentTarget.classList.add("active");
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
