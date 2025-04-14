import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { duration: Number };

  connect() {
    setTimeout(() => {
      this.element.remove();
    }, this.durationValue || 3000);
  }
}
