import { initMapbox } from "../plugins/init_mapbox";

const loadDarkLightModeToggle = () => {
  let lightMode = localStorage.getItem("lightMode");
  console.log(lightMode)

  const lightModeToggle = document.querySelector("#light-mode-toggle");

  const enableLightMode = () => {
    document.body.classList.add("light-theme");
    localStorage.setItem("lightMode", "true");
  };

  const disableLightMode = () => {
    document.body.classList.remove("light-theme");
    localStorage.setItem("lightMode", null);
  };
  if (lightMode === "true") {
    lightModeToggle.checked = true;
    enableLightMode();


  }
  if (lightModeToggle) {
    lightModeToggle.addEventListener("click", () => {
      lightMode = localStorage.getItem("lightMode");
      if (lightMode !== "true") {
        lightModeToggle.checked = true;
        enableLightMode();
        initMapbox();
        // map.style = 'mapbox://styles/mapbox/light-v10';
      } else {
        lightModeToggle.checked = false;
        disableLightMode();
        initMapbox();
        // map.style = 'mapbox://styles/mapbox/dark-v10';
      }
    });
  }
};

export default loadDarkLightModeToggle;
