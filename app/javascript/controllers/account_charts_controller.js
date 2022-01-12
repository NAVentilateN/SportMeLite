import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [
    "charts"
  ];

  connect() {
    console.log(this.element)
  }

  displayCharts(e) {
    const url = e.currentTarget.href;
    fetch(url, {
      method: "GET",
      headers: { Accept: "text/plain" },
    })
      .then((response) => response.text())
      .then((data) => {
        console.log(data);
        this.chartsTarget.outerHTML = data;
      });
    // $(".chart-header-link.active").removeClass("active");
    // e.currentTarget.classList.add("active");
  }

}
