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
    lightModeToggle.checked = false;
    enableLightMode();
  } else {
      lightModeToggle.checked = true;
  }
  if (lightModeToggle) {
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
