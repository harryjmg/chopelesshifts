import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // If a timer is already running, clear it
    if (window.modalTimer) {
      clearTimeout(window.modalTimer);
    }

    window.modalTimer = setTimeout(() => {
      this.modal = new bootstrap.Modal(this.element);
      this.modal.show();

      // Listen to the modal hidden event
      this.element.addEventListener('hidden.bs.modal', () => {
        // Remove the modal
        this.element.remove();
      });
    }, 500);
  }
}
