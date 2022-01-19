import { initMapbox } from "../plugins/init_mapbox";

const loadDarkLightModeToggle = () => {
  let lightMode = localStorage.getItem("lightMode");

  const lightModeToggle = document.querySelector("#light-mode-toggle");
  const navBar = document.querySelector(".navbar");

  const enableLightMode = () => {
    document.body.classList.add("light-theme");
    localStorage.setItem("lightMode", "true");
    if (!window.location.path === '/') {
    navBar.classList.remove("navbar-dark");
    navBar.classList.add("navbar-light");
    }
  };

  const disableLightMode = () => {
    document.body.classList.remove("light-theme");
    localStorage.setItem("lightMode", null);
    navBar.classList.remove("navbar-light");
    navBar.classList.add("navbar-dark");
  };
  if (lightModeToggle) {
    if (lightMode === "true") {
      lightModeToggle.checked = false;
      enableLightMode();
    } else {
      lightModeToggle.checked = true;
    }

    lightModeToggle.addEventListener("click", () => {
      lightMode = localStorage.getItem("lightMode");
      if (lightMode !== "true") {
        lightModeToggle.checked = false;
        enableLightMode();
        initMapbox();
        // map.style = 'mapbox://styles/mapbox/light-v10';
      } else {
        lightModeToggle.checked = true;
        disableLightMode();
        initMapbox();
        // map.style = 'mapbox://styles/mapbox/dark-v10';
      }
    });
  }
};

export default loadDarkLightModeToggle;
