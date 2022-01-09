import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['selection', 'list'];

  connect() {
    console.log(this);
    console.log(this.listTarget);
    // console.log(this.selectionTarget);
  }
}
