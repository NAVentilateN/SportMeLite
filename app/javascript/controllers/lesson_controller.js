import { Controller } from "stimulus"
import { calendar } from '../packs/calendar'


export default class extends Controller {

  static targets = ['card', 'modalContent', 'lessonModal', 'editForm', 'newBtn', 'newForm', 'list', 'lessonsList']

  // connect () {
  //   console.log(this.modalContentTarget)
  //   console.log(this.cardTarget)
  //   console.log(this.newBtnTarget)
    // console.log(this.listTarget)
  //   console.log(this.modalContentShowTarget)
    // console.log(this.lessonsListTarget)
  //   console.log(this)
  // }

  //show lesson method
  displayShowForm(event) {
    event.preventDefault();
    const url = event.currentTarget.href
    fetch(url, {
      method: 'GET',
      headers: { 'Accept': 'text/plain' },
    }).then(response => 
      response.text())
    .then((data) => {
      this.modalContentTarget.innerHTML = data
    })
    $('#lessonModal').modal('show');
  }

 
  //new lesson methods
  displayNewForm(event) {
    event.preventDefault();
    const url = this.newBtnTarget.href
    fetch(url, {
      method: 'GET',
      headers: { 'Accept': 'text/plain' },
    }).then(response => 
      response.text())
    .then((data) => {
      this.modalContentTarget.innerHTML = data
      this.newFormTarget.classList.remove('d-none')  //form rendered in async func. Can only reference it after data from async is rendered in modal.
    })
    $('#lessonModal').modal('show');
  }

    create(event) {
      event.preventDefault();
      const url = this.newFormTarget.action
      fetch(url, {
        method: 'POST',
        headers: { 'Accept': 'text/plain' },
        body: new FormData(this.newFormTarget)
      })
        .then(response => {
          console.log(response)
          response.text()})
        .then((data) => {
          console.log(data)
          this.listTarget.outerHTML = data;
        })
    }
  

  //edit lesson methods
  displayEditForm(event) {
    // event.preventDefault();
    const url = event.currentTarget.href
    fetch(url, {
      method: 'GET',
      headers: { 'Accept': 'text/plain' },
    }).then(response => 
      response.text())
    .then((data) => {
      this.modalContentTarget.innerHTML = data
      this.editFormTarget.classList.remove('d-none')
    })
    $('#lessonModal').modal('show');
  }

  update(event) {
    event.preventDefault();
    const lessonId = this.editFormTarget.action.split('/')[5]
    const cardTarget = this.cardTargets.find((cardEl)=> cardEl.dataset.id === lessonId)
    const startDateTime = $('#lesson_start_date_time').val()
    const endDateTime = $('#lesson_end_date_time').val()
    const lessonDescription = $('#lesson_description').val()
    const url = this.editFormTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.editFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        cardTarget.outerHTML = data;
        //updating the calendar
        calendar.getEventById(lessonId).remove()
        calendar.addEvent({
          id: lessonId,
          start: new Date(startDateTime),
          end: new Date(endDateTime),
          title: 'HELLO',
          backgroundColor: 'red',
          textColor: 'white',
          extendedProps: {
            description: lessonDescription
          }
        })
      })
      $('#lessonModal').modal('hide');
  }


  //navlink lesson methods
  displayLessons(event) {
    const url = event.currentTarget.href
    fetch(url, {
      method: 'GET',
      headers: { 'Accept': 'text/plain' },
    })
      .then(response => response.text())
      .then((data) => {
        this.lessonsListTarget.outerHTML = data;
      })
      $('.lesson-header-link.active').removeClass('active'); 
      event.currentTarget.classList.add('active')
  }
}