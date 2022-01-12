// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import { initMapbox } from "../plugins/init_mapbox";
import { loadCalendar, clearCalendar, calendar } from "./calendar";
import "chartkick/chart.js"
import loadDarkLightModeToggle from "./toggleLightDarkMode"

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { initChatCable } from "../channels/chat_channel";

// Internal imports, e.g:
// Navbar toggle switch
let toggleCoachNavbar = () => {
  const toggler = document.querySelector(".custom-control-input");
  const my_lessons_btn = document.querySelector(".my-lessons-btn");
  const coach_lessons_btn = document.querySelector(".coach-lessons-btn");
  const coach_profile_btn = document.querySelector(".coach-profile-btn");
  const coach_accounts_btn = document.querySelector(".coach-accounts-btn");

  if (toggler) {
    toggler.addEventListener("change", (event) => {
      my_lessons_btn.classList.toggle("hide");
      coach_lessons_btn.classList.toggle("hide");
      coach_profile_btn.classList.toggle("hide");
      coach_accounts_btn.classList.toggle("hide");

      const label = document.getElementById("toggleLabel");
      if (label.innerText == "Student") {
        label.innerText = "Coach";
      } else {
        label.innerText = "Student";
      }
    });
  }
};

const toggleCoachLessons = () => {
  const coachLessonList = document.querySelector(".coach-lesson-container");
  const toggleBtn = document.querySelector("#coach-toggle-btn");
  if (toggleBtn) {
    toggleBtn.addEventListener("click", () => {
      if (coachLessonList.classList.contains("show-lessons")) {
        toggleBtn.innerText = "Show Lessons";
      } else {
        toggleBtn.innerText = "Hide Lessons";
      }
      coachLessonList.classList.toggle('show-lessons')
  });
}};

const scrollToBottom = () => {
  const scrollBar = document.querySelector(".chat-history");
  if (scrollBar) {
    console.log(scrollBar);
    scrollBar.scrollTop = scrollBar.scrollHeight;
  };
};

document.addEventListener("turbolinks:load", () => {
  // Call your functions here, e.g:
  // initSelect2();
  toggleCoachNavbar();
  toggleCoachLessons();
  initChatCable();
  scrollToBottom();
  loadCalendar();
  if(calendar) {
    // $('[data-toggle="tooltip"]').tooltip()
    calendar.render();
  }
  loadDarkLightModeToggle();
});

document.addEventListener("turbolinks:before-cache", clearCalendar());
import "controllers";
initMapbox();
window.initMapbox = initMapbox;
