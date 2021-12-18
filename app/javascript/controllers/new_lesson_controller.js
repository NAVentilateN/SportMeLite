import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['form', 'list']

  // connect () {
  //   // console.log(this.newLessonBtnTarget)
  //   // console.log(this.formTarget)
  // }

  displayForm() {
    this.formTarget.classList.remove('d-none');
  }

  create(event) {
    event.preventDefault();
    const url = this.formTarget.action
    console.log(url)
    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
        this.listTarget.outerHTML = data;
      })
  }
}
