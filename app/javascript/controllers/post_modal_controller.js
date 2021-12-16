import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['container'];

  connect() {
    console.log('hello', this.element)
    super.connect();
    console.log(this.hasSourceTarget)
  }

  open(e) {
    console.log(e.target)
    if (this.preventDefaultActionOpening) {
      e.preventDefault();
    }

    // document.addEventListener("postForm:load", () => {
    //   console.log('LOADED')
    // });
  }
}
