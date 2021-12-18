import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['form', 'card', 'modalContent', 'editModal', 'editBtn']

  connect () {
    // console.log(this.formTarget)
    // console.log(this.cardTarget)
    // console.log(this.editModalTarget)
    console.log(this.modalContentTarget)
    // console.log(this.editBtnTarget)
  }

  displayForm(event) {
    event.preventDefault();
    
    
    const url = this.editBtnTarget.href
    fetch(url, {
      method: 'GET',
    }).then(response => {
      const data = response.json()})
    .then((data) => {
      console.log(data)
      this.modalContentTarget.appendChild(data)
    })

   
    this.formTarget.classList.remove('d-none')
    $('#editModal').modal('show');
    
  }

  update(event) {
    event.preventDefault();
    const url = this.formTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data;
      })
  }
}
