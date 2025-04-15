import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  get hiddenClass() {
    return "hidden";
  }

  get showClasses() {
    return ["opacity-100", "scale-100", "pointer-events-auto"];
  }

  get hideClasses() {
    return ["opacity-0", "scale-95", "pointer-events-none"];
  }

  connect() {
    this.handleClickOutside = this.handleClickOutside.bind(this);
    this.handleEscape = this.handleEscape.bind(this);
    document.addEventListener("click", this.handleClickOutside);
    document.addEventListener("keydown", this.handleEscape);
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside);
    document.removeEventListener("keydown", this.handleEscape);
  }

  toggle(event) {
    event.stopPropagation();
    if (this.menuTarget.classList.contains(this.hiddenClass)) {
      this.openMenu();
    } else {
      this.closeMenu();
    }
  }

  openMenu() {
    this.menuTarget.classList.remove(this.hiddenClass, ...this.hideClasses);
    this.menuTarget.classList.add(...this.showClasses);

    this.menuTarget.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", this.closeMenu.bind(this));
    });
  }

  closeMenu() {
    this.menuTarget.classList.add(...this.hideClasses);
    this.menuTarget.classList.remove(...this.showClasses);
    setTimeout(() => {
      this.menuTarget.classList.add(this.hiddenClass);
    }, 150);
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.closeMenu();
    }
  }

  handleEscape(event) {
    if (event.key === "Escape") {
      this.closeMenu();
    }
  }
}
