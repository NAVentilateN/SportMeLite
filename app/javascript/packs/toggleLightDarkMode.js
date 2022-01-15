const loadDarkLightModeToggle = () => {
  let lightMode = localStorage.getItem("lightMode");

  const lightModeToggle = document.querySelector("#light-mode-toggle");
  const navBar = document.querySelector(".navbar");

  const enableLightMode = () => {
    document.body.classList.add("light-theme");
    localStorage.setItem("lightMode", "true");
    navBar.classList.remove("navbar-dark");
    navBar.classList.add("navbar-light");
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
      } else {
        lightModeToggle.checked = true;
        disableLightMode();
      }
    });
  }
};

export default loadDarkLightModeToggle;
