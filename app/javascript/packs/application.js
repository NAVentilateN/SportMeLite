// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
  // Navbar toggle switch
  let toggle = () => {
    const toggler = document.querySelector(".custom-control-input");
    const my_lessons_btn = document.querySelector(".my-lessons-btn");
    const coach_lessons_btn = document.querySelector(".coach-lessons-btn");
    const coach_profile_btn = document.querySelector(".coach-profile-btn");

    toggler.addEventListener('change', (event) => {
        my_lessons_btn.classList.toggle("hide")
        coach_lessons_btn.classList.toggle("hide")
        coach_profile_btn.classList.toggle("hide")
        const label = document.getElementById("toggleLabel")
        if (label.innerText == 'Student') {
          label.innerText = "Coach";
        } else {
          label.innerText = "Student";
        }
    });
  }

// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  toggle();
});
