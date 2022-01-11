import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["selection", "list"];

  displayLessons(e) {
    const url = e.currentTarget.href;
    fetch(url, {
      method: "GET",
      headers: { Accept: "text/plain" },
    })
      .then((response) => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data;
      });
  }
}
