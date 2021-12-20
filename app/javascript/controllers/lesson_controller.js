import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['card', 'modalContent', 'lessonModal', 'editForm', 'newBtn', 'newForm', 'list', 'modalContentShow']

  connect () {
  //   console.log(this.modalContentTarget)
  //   console.log(this.cardTarget)
  //   console.log(this.newBtnTarget)
    console.log(this.listTarget)
  //   console.log(this.modalContentShowTarget)
  }

  //show lesson methods
  displayShowForm(event) {
    const url = event.currentTarget.href
    fetch(url, {
      method: 'GET',
      headers: { 'Accept': 'text/plain' },
    }).then(response => 
      response.text())
    .then((data) => {
      this.modalContentShowTarget.innerHTML = data
    })
    $('#lessonModal').modal('show');
  }

 
  //new lesson methods
  displayNewForm() {
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
    const url = this.editFormTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.editFormTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data;
      })
  }

}