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

document.addEventListener("turbolinks:load", () => {
  const button = document.getElementById("dropdown-button");
  const menu = document.getElementById("dropdown-menu");

  if (button && menu) {
    button.addEventListener("click", (e) => {
      e.stopPropagation();
      menu.classList.toggle("show");
    });
  }

  document.addEventListener("click", () => {
    const menu = document.getElementById("dropdown-menu");
    if (menu){
      menu.classList.remove("show");
    }
  })
})

document.addEventListener("DOMContentLoaded", () => {
  const flash = document.querySelector(".notice, .alert");
  if (flash) {
    setTimeout(() => {
      flash.style.transition = "opacity 0.5s";
      flash.style.opacity = 0;
      setTimeout(() => flash.remove(), 500);
    }, 3000);
  }
});
