import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["new_lesson_btn", 'form', 'card']

  connect () {
    // console.log(this.newLessonBtnTarget)
    // console.log(this.formTarget)
  }

  displayForm() {
    this.formTarget.classList.remove('d-none')
  }

  create(event) {
    event.preventDefault();
    const url = this.formTarget.action
    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data);
      })
  }
}
