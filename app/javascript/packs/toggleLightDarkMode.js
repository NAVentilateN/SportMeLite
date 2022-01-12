const loadDarkLightModeToggle = () => {
  let lightMode = localStorage.getItem("lightMode");

  const darkModeToggle = document.querySelector("#light-mode-toggle");

  const enableLightMode = () => {
    document.body.classList.add("light-theme");
    localStorage.setItem("lightMode", "true");
  };

  const disableLightMode = () => {
    document.body.classList.remove("light-theme");
    localStorage.setItem("lightMode", null);
  };
  if (lightMode === "enabled") {
    enableLightMode();
  }
  if (darkModeToggle) {
    darkModeToggle.addEventListener("click", () => {
      lightMode = localStorage.getItem("lightMode");
      if (lightMode !== "true") {
        enableLightMode();
      } else {
        disableLightMode();
      }
    });
  }
};

export default loadDarkLightModeToggle;
