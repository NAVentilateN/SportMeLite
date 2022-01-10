import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['selection', 'list'];

  displayLessons() {
    // console.log("hi from lesson");
    const url = 'http://localhost:3000/locations/75/sports/2'
    fetch(url, {
      method: "GET",
      headers: { Accept: "text/plain" },
    })
      .then((response) =>  response.text())
      .then((data) => {
        console.log(data)
        // this.lessonsListTarget.outerHTML = data;
      });
  //   $(".lesson-header-link.active").removeClass("active");
  //   e.currentTarget.classList.add("active");
  // }
  }
}
