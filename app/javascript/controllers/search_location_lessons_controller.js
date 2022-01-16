import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["selection", "list", "filter"];

  displayLocationLessons(e) {
    let url
    if (e.currentTarget.href == null) {
      url = `/locations/${document.querySelector('.filter-input-location').value}/lessons`;
    } else {
      url = e.currentTarget.href;
    }

    fetch(url, {
      method: "GET",
      headers: { Accept: "text/plain" },
    })
      .then((response) => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data;
      });
      document.querySelector('.lesson-list').scrollIntoView({
        block: "start",
        behavior: 'smooth'
      });
  }
}
