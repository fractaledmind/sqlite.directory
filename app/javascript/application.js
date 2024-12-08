// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

const dismissableElements = document.querySelectorAll("[dismissable]")
document.addEventListener('click', event => {
  dismissableElements.forEach(element => {
    if (element === event.target || element.contains(event.target)) return;

    element.open = false
  })
})