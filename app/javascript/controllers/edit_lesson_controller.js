import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['form', 'card', 'modal']

  connect () {
    // console.log(this.infosTarget)
    // console.log(this.formTarget)
    // console.log(this.cardTarget)
  }

  displayForm() {
    this.formTarget.classList.remove('d-none')
    console.log(this.formTarget.action)
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
