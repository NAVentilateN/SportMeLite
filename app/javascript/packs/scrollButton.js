const scrollButtonBehavior = () => {
  const scrollBtn = document.querySelector("#scrollToTopBtmBtn");
  const rootElement = document.documentElement;
  const navBar = document.querySelector(".navbar");
  const footer = document.querySelector("footer");

  const scrollToTop = () => {
    rootElement.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  };

  const observeNavBar = (entries, observer) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        scrollBtn.classList.remove("showBtn");
      } else {
        scrollBtn.classList.add("showBtn");
      }
    });
  };

  const observeFooter = (entries, observer) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        scrollBtn.classList.add("stickBtn");
      } else {
        scrollBtn.classList.remove("stickBtn");
      }
    });
  };

  const observer = new IntersectionObserver(observeNavBar);
  const observer2 = new IntersectionObserver(observeFooter);
  observer.observe(navBar);
  observer2.observe(footer);

  scrollBtn.addEventListener("click", scrollToTop);
};

export default scrollButtonBehavior;
