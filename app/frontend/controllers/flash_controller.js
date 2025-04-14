import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { duration: Number };

  connect() {
    this.element.classList.add("opacity-0", "translate-y-2");
    requestAnimationFrame(() => {
      this.element.classList.remove("opacity-0", "translate-y-2");
      this.element.classList.add(
        "opacity-100",
        "translate-y-0",
        "transition",
        "duration-300",
        "ease-out"
      );
    });

    setTimeout(() => {
      this.element.classList.remove("opacity-100", "translate-y-0");
      this.element.classList.add("opacity-0", "translate-y-2");

      setTimeout(() => {
        this.element.remove();
      }, 300);
    }, this.durationValue || 4000);
  }
}
