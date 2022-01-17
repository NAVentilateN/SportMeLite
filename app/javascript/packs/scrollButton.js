const scrollButtonBehavior = () => {
  const scrollBtn = document.querySelector("#scrollToTopBtmBtn");
  const homeScrollBtn = document.querySelector("#homeScrollBtn");
  const rootElement = document.documentElement;
  const navBar = document.querySelector(".navbar");
  const footer = document.querySelector("footer");
  const carouselRow = document.querySelector('.row');

  const scrollToTop = () => {
    rootElement.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  };

  const scrollToBottom = () => {
    homeScrollBtn.classList.add('hide');
    carouselRow.scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
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

  const observer = new IntersectionObserver(observeNavBar);
  observer.observe(navBar);

  scrollBtn.addEventListener("click", scrollToTop);
  if (homeScrollBtn) {
    homeScrollBtn.addEventListener("click", scrollToBottom);
  }
};

export default scrollButtonBehavior;
